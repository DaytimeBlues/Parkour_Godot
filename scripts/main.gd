extends Node3D

const Avatar = preload("res://scripts/avatar.gd")
const Player = preload("res://scripts/player.gd")
const Network = preload("res://scripts/network.gd")
var player: WoodlandPlayer
var network: WoodlandNetwork
var peers: Dictionary = {}
var status: Label
var network_status: Label
var metrics: Label
var menu: PanelContainer
var start_button: Button
var room_field: LineEdit
var dragging := false
var ui_clock := 0.0
var relay_url := "ws://127.0.0.1:49237"
var status_text := "Ready · reach the turquoise arch"
var collider_parts := 0
var collision_triangles := 0
var runtime_frames := 0

func _ready() -> void:
	_setup_inputs()
	_setup_environment()
	_load_woodland()
	player = Player.new()
	add_child(player)
	network = Network.new()
	add_child(network)
	network.status_changed.connect(func(text: String): network_status.text = text)
	network.snapshot_received.connect(_update_peers)
	_setup_ui()
	get_viewport().size_changed.connect(_layout_ui)
	get_window().focus_exited.connect(func(): _pause())
	print("GODOT_PROTOTYPE_READY parts=%s triangles=%s" % [collider_parts, collision_triangles])

func _setup_inputs() -> void:
	var bindings := {"forward": [KEY_W, KEY_UP], "back": [KEY_S, KEY_DOWN], "left": [KEY_A, KEY_LEFT], "right": [KEY_D, KEY_RIGHT], "jump": [KEY_SPACE], "dive": [KEY_X], "turn_left": [KEY_Q], "turn_right": [KEY_E]}
	for action in bindings:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		for key in bindings[action]:
			var event := InputEventKey.new()
			event.physical_keycode = key
			InputMap.action_add_event(action, event)

func _setup_environment() -> void:
	var environment := Environment.new()
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color("86b4bb")
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("c4ded4")
	environment.ambient_light_energy = 0.8
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.fog_enabled = true
	environment.fog_light_color = Color("86b4bb")
	environment.fog_density = 0.008
	var world := WorldEnvironment.new()
	world.environment = environment
	add_child(world)
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-50, -35, 0)
	sun.light_color = Color("ffe6b5")
	sun.light_energy = 1.1
	sun.shadow_enabled = false
	add_child(sun)

func _load_woodland() -> void:
	var model: Node3D = load("res://assets/woodland.glb").instantiate()
	add_child(model)
	var contract: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://assets/collision.json"))
	var points := PackedVector3Array()
	var raw: Array = contract.faces
	for i in range(0, raw.size(), 3):
		points.append(Vector3(raw[i], raw[i + 1], raw[i + 2]))
	var shape := ConcavePolygonShape3D.new()
	shape.set_faces(points)
	var body := StaticBody3D.new()
	var collider := CollisionShape3D.new()
	collider.shape = shape
	body.add_child(collider)
	add_child(body)
	collider_parts = contract.parts.size()
	collision_triangles = points.size() / 3
	# The existing goal diamond stays decorative. This separate translucent marker is diagnostic.
	var ring := MeshInstance3D.new()
	var torus := TorusMesh.new()
	torus.inner_radius = 0.9
	torus.outer_radius = 1.0
	torus.rings = 24
	torus.ring_segments = 8
	ring.mesh = torus
	ring.position = Vector3(12.7, 3.76, -6.4)
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color("78f5db")
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	ring.material_override = mat
	add_child(ring)

func _label(text: String, size: int = 16) -> Label:
	var label := Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", size)
	label.add_theme_color_override("font_color", Color("edf7ed"))
	return label

func _button(text: String, callback: Callable) -> Button:
	var button := Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(110, 42)
	button.pressed.connect(callback)
	button.focus_mode = Control.FOCUS_NONE
	return button

func _panel() -> PanelContainer:
	var panel := PanelContainer.new()
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.035, 0.09, 0.09, 0.90)
	style.corner_radius_top_left = 12
	style.corner_radius_top_right = 12
	style.corner_radius_bottom_left = 12
	style.corner_radius_bottom_right = 12
	style.content_margin_left = 20
	style.content_margin_right = 20
	style.content_margin_top = 14
	style.content_margin_bottom = 14
	panel.add_theme_stylebox_override("panel", style)
	return panel

func _setup_ui() -> void:
	var layer := CanvasLayer.new()
	layer.name = "CanvasLayer"
	add_child(layer)
	var root := Control.new()
	root.name = "UI"
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layer.add_child(root)
	var header := _panel()
	header.name = "Header"
	root.add_child(header)
	header.position = Vector2(18, 18)
	var stack := VBoxContainer.new()
	header.add_child(stack)
	stack.add_child(_label("PARKOUR  /  GODOT WOODLAND", 22))
	stack.add_child(_label("Engine comparison · existing fox + wings + woodland", 14))
	status = _label(status_text)
	stack.add_child(status)
	network_status = _label("Solo · local relay disconnected", 14)
	stack.add_child(network_status)
	var footer := _panel()
	footer.name = "Footer"
	root.add_child(footer)
	var footstack := VBoxContainer.new()
	footer.add_child(footstack)
	footstack.add_child(_label("WASD / arrows move  ·  drag mouse or Q/E turn  ·  Space jump / hold climb", 15))
	footstack.add_child(_label("Release Space glide  ·  X dive  ·  V camera  ·  R restart  ·  Esc pause", 15))
	metrics = _label("Compatibility renderer · shadows off · fixed 60Hz physics", 13)
	footstack.add_child(metrics)
	menu = _panel()
	menu.name = "Menu"
	root.add_child(menu)
	var menustack := VBoxContainer.new()
	menustack.add_theme_constant_override("separation", 12)
	menu.add_child(menustack)
	menustack.add_child(_label("A small woodland. A familiar fox.", 23))
	menustack.add_child(_label("Walk north along the stones, turn right up the stairs,\ncross the root bridge and find the turquoise arch.\nJump, climb, then release Space to glide.", 17))
	start_button = _button("Start exploring", _start)
	menustack.add_child(start_button)
	var controls := HBoxContainer.new()
	menustack.add_child(controls)
	controls.add_child(_button("Restart", _reset))
	controls.add_child(_button("Switch view (V)", _switch_view))
	var connection := HBoxContainer.new()
	menustack.add_child(connection)
	room_field = LineEdit.new()
	room_field.text = "FOREST"
	room_field.max_length = 12
	room_field.custom_minimum_size = Vector2(140, 42)
	room_field.placeholder_text = "Local room"
	connection.add_child(room_field)
	connection.add_child(_button("Join local relay", func(): network.join_local(relay_url, room_field.text)))
	connection.add_child(_button("Disconnect", func(): network.disconnect_local()))
	menustack.add_child(_label("Experimental Godot physics + local visual peers.\nNo production rooms, scores, teacher tools or student data.\nNot a complete migration or school-laptop performance pass.", 13))
	_layout_ui()

func _layout_ui() -> void:
	var size := get_viewport().get_visible_rect().size
	var root := get_node("CanvasLayer/UI")
	var footer: Control = root.get_node("Footer")
	footer.position = Vector2(18, size.y - 106)
	footer.size = Vector2(minf(size.x - 36, 810), 88)
	menu.reset_size()
	menu.position = (size - menu.size) / 2

func _start() -> void:
	menu.hide()
	player.set_playing(true)
	start_button.text = "Resume exploring"
	get_viewport().gui_release_focus()

func _pause() -> void:
	dragging = false
	player.set_playing(false)
	menu.show()

func _reset() -> void:
	player.reset_run()
	status_text = "Ready · reach the turquoise arch"
	_pause()

func _switch_view() -> void:
	player.first_person = not player.first_person

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.physical_keycode == KEY_ESCAPE:
			if player.playing:
				_pause()
			else:
				_start()
		elif event.physical_keycode == KEY_R:
			_reset()
		elif event.physical_keycode == KEY_V:
			_switch_view()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed and player.playing
	if event is InputEventMouseMotion and dragging:
		player.look(event.relative)

func _process(dt: float) -> void:
	runtime_frames += 1
	for id in peers:
		var peer: Dictionary = peers[id]
		peer.node.position = peer.node.position.lerp(peer.target, minf(1.0, dt * 14))
		peer.node.rotation.y = lerp_angle(peer.node.rotation.y, peer.yaw, minf(1.0, dt * 14))
	network.latest_state = {"position": [player.position.x, player.position.y - 0.9, player.position.z], "yaw": player.yaw, "grounded": player.is_on_floor(), "gliding": player.gliding, "speed": Vector2(player.velocity.x, player.velocity.z).length()}
	ui_clock += dt
	if ui_clock < 0.25:
		return
	ui_clock = 0
	var state := "ON FOOT" if player.is_on_floor() else ("GLIDING" if player.gliding else "DIVING")
	if player.velocity.y > 0.2 and not player.is_on_floor():
		state = "CLIMBING"
	status.text = "Arch reached!  R to restart" if player.completed else "%s  ·  altitude %.1fm  ·  falls %s" % [state, player.position.y - 0.9, player.falls]
	metrics.text = "%s FPS (this device only)  ·  %s draws  ·  %s triangles  ·  peers %s/7" % [Engine.get_frames_per_second(), RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_DRAW_CALLS_IN_FRAME), RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_PRIMITIVES_IN_FRAME), peers.size()]
	if OS.has_feature("web"):
		var report := player.telemetry()
		report["peers"] = peers.size()
		report["relay_connected"] = network.connected
		JavaScriptBridge.eval("window.parkourTelemetry = " + JSON.stringify(report) + ";", true)

func _update_peers(snapshot: Array) -> void:
	var present := {}
	for data in snapshot:
		if not data is Dictionary or data.get("id", "") == network.local_id:
			continue
		var id := str(data.get("id", ""))
		var state: Dictionary = data.get("state", {})
		var position_value = state.get("position")
		if id.is_empty() or not position_value is Array or position_value.size() != 3:
			continue
		var target := Vector3(float(position_value[0]), float(position_value[1]), float(position_value[2]))
		if not target.is_finite() or target.length() > 100:
			continue
		present[id] = true
		if not peers.has(id):
			var avatar := Avatar.new()
			add_child(avatar)
			avatar.position = target
			peers[id] = {"node": avatar, "target": target, "yaw": 0.0}
		peers[id].target = target
		peers[id].yaw = float(state.get("yaw", 0))
		peers[id].node.pose(bool(state.get("grounded", true)), bool(state.get("gliding", false)), float(state.get("speed", 0)))
	for id in peers.keys():
		if not present.has(id):
			peers[id].node.queue_free()
			peers.erase(id)

func _exit_tree() -> void:
	if network:
		network.disconnect_local()
