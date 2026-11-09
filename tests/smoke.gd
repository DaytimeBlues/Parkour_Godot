extends SceneTree
var root_scene: Node3D
var samples: Dictionary = {}
var failures: Array[String] = []

func check(value: bool, message: String) -> void:
	if not value:
		failures.append(message)

func frames(count: int) -> void:
	for i in count:
		await physics_frame

func _initialize() -> void:
	call_deferred("run")

func finish_course(p: WoodlandPlayer) -> void:
	# Synthetic normal movement through the actual colliders, never a teleport.
	for target in [Vector2(-5, -4.2), Vector2(12.7, -4.2), Vector2(12.7, -6.4)]:
		for frame in 600:
			var offset: Vector2 = target - Vector2(p.position.x, p.position.z)
			if offset.length() < 0.2 or p.completed:
				break
			for action in ["forward", "back", "left", "right"]:
				Input.action_release(action)
			if absf(offset.x) > 0.12:
				Input.action_press("right" if offset.x > 0 else "left")
			if absf(offset.y) > 0.12:
				Input.action_press("back" if offset.y > 0 else "forward")
			await physics_frame
	for action in ["forward", "back", "left", "right"]:
		Input.action_release(action)
	await frames(3)

func run() -> void:
	root_scene = load("res://main.tscn").instantiate()
	root.add_child(root_scene)
	await frames(3)
	var ui := root_scene.get_node_or_null("CanvasLayer/UI") as Control
	var header := root_scene.get_node_or_null("CanvasLayer/UI/Header") as Control
	var footer := root_scene.get_node_or_null("CanvasLayer/UI/Footer") as Control
	var menu_node := root_scene.get_node_or_null("CanvasLayer/UI/Menu") as Control
	check(ui != null, "UI root exists under CanvasLayer")
	check(header != null, "header exists under UI")
	check(footer != null, "footer exists under UI")
	check(menu_node != null and menu_node == root_scene.menu, "menu exists under UI")
	if footer != null:
		var viewport_size := root.get_viewport().get_visible_rect().size
		check(footer.position.is_equal_approx(Vector2(18, viewport_size.y - 106)), "footer laid out at viewport bottom")
		check(is_equal_approx(footer.size.x, minf(viewport_size.x - 36, 810)), "footer width fits viewport")
	var p: WoodlandPlayer = root_scene.player
	check(root_scene.collider_parts == 86, "86 collision parts")
	check(root_scene.collision_triangles == 5336, "5336 collision triangles")
	check(p.avatar.body_animation != null, "fox AnimationPlayer imported")
	check(p.avatar.wing_animation != null, "Angel AnimationPlayer imported")
	check(not p.avatar.actual_clip(p.avatar.body_animation, "AvatarRun").is_empty(), "AvatarRun name unchanged")
	p.set_playing(true)
	await frames(30)
	samples.spawn = p.telemetry()
	check(p.is_on_floor(), "spawn supported")
	check(absf(p.position.y - 2.955) < 0.12, "fox feet on original map")
	Input.action_press("forward")
	await frames(60)
	Input.action_release("forward")
	samples.walk = p.telemetry()
	check(p.position.z < 3, "forward movement")
	Input.action_press("jump")
	await frames(45)
	samples.climb = p.telemetry()
	check(not p.is_on_floor() and p.velocity.y > 0, "held climb")
	Input.action_release("jump")
	await frames(45)
	samples.glide = p.telemetry()
	check(p.gliding and p.velocity.y < 0 and p.velocity.y >= -2.401, "released glide descent")
	Input.action_press("dive")
	await frames(10)
	samples.dive = p.telemetry()
	check(p.velocity.y < -5, "dive acceleration")
	Input.action_release("dive")
	await frames(120)
	samples.landing = p.telemetry()
	check(p.is_on_floor(), "landing after dive")
	root_scene._pause()
	var position_before := p.position
	Input.action_press("forward")
	await frames(30)
	Input.action_release("forward")
	check(p.position == position_before, "paused movement stopped")
	root_scene._switch_view()
	check(p.first_person, "first-person toggle")
	root_scene._reset()
	await frames(2)
	check(p.position.distance_to(p.SPAWN) < 0.01 and not p.playing and p.falls == 0, "restart reset")
	root_scene._start()
	await frames(30)
	await finish_course(p)
	samples.course_finish = p.telemetry()
	check(p.completed and p.falls == 0, "actual stone-stair-bridge course completed without falls")
	check(not p.playing and p.velocity == Vector3.ZERO, "finish stops input and velocity")
	check(root_scene.menu.visible and root_scene.start_button.text == "Run again", "finish shows repeat-run action")
	var finish_time := p.elapsed
	var finish_position := p.position
	Input.action_press("forward")
	Input.action_press("jump")
	await frames(90)
	Input.action_release("forward")
	Input.action_release("jump")
	check(is_equal_approx(p.elapsed, finish_time), "finished run time is frozen")
	check(p.position == finish_position, "finished run ignores movement and jump")
	root_scene._pause()
	check(root_scene.start_button.text == "Run again", "focus pause preserves results")
	root_scene._start()
	check(not p.completed and p.playing and p.falls == 0 and is_zero_approx(p.elapsed), "run again starts fresh")
	check(not root_scene.menu.visible, "run again closes results")
	await frames(30)
	root_scene._pause()
	var paused_time := p.elapsed
	await frames(30)
	check(is_equal_approx(p.elapsed, paused_time), "pause freezes run timer")
	root_scene._start()
	await finish_course(p)
	check(p.completed and not p.playing, "second course run can finish")
	root_scene._reset()
	check(not p.completed and not p.playing and root_scene.menu.visible, "restart from results returns to fresh menu")
	check(root_scene.start_button.text == "Start exploring", "fresh restart action label restored")
	var report := {"evidence_type":"Headless Godot source/physics test using Input.action_press; not ordinary browser input or rendered acceptance", "samples":samples, "failures":failures, "pass":failures.is_empty()}
	var file := FileAccess.open("res://evidence/headless-smoke.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(report, "  ") + "\n")
	print(JSON.stringify(report))
	root_scene.queue_free()
	await process_frame
	quit(0 if failures.is_empty() else 1)
