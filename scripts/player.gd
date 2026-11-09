class_name WoodlandPlayer
extends CharacterBody3D
## Comparison controller only. Same nominal speeds; not a physics port or parity claim.
const SPAWN := Vector3(-5, 2.98, 8)
const GOAL := Vector3(12.7, 3.655, -6.4)
const SPEED := 7.2
var yaw := 0.0
var pitch := -0.26
var playing := false
var first_person := false
var gliding := false
var falls := 0
var completed := false
var elapsed := 0.0
var jump_buffer := 0.0
var coyote := 0.0
var avatar: WoodlandAvatar
var pivot: Node3D
var arm: SpringArm3D
var camera: Camera3D
var landed_steps := 0

func _ready() -> void:
	var capsule := CapsuleShape3D.new()
	capsule.radius = 0.35
	capsule.height = 1.8
	var collision := CollisionShape3D.new()
	collision.shape = capsule
	add_child(collision)
	floor_snap_length = 0.18
	floor_max_angle = PI / 4
	floor_stop_on_slope = true
	avatar = WoodlandAvatar.new()
	add_child(avatar)
	avatar.position.y = -0.9
	pivot = Node3D.new()
	add_child(pivot)
	pivot.position.y = 0.55
	arm = SpringArm3D.new()
	pivot.add_child(arm)
	arm.spring_length = 5.0
	arm.margin = 0.18
	var camera_sphere := SphereShape3D.new()
	camera_sphere.radius = 0.18
	arm.shape = camera_sphere
	arm.add_excluded_object(get_rid())
	camera = Camera3D.new()
	arm.add_child(camera)
	camera.fov = 72
	camera.near = 0.08
	camera.current = true
	reset_run()

func reset_run() -> void:
	position = SPAWN
	velocity = Vector3.ZERO
	yaw = 0
	pitch = -0.26
	falls = 0
	elapsed = 0
	completed = false
	jump_buffer = 0
	coyote = 0
	gliding = false
	landed_steps = 0

func respawn() -> void:
	position = SPAWN
	velocity = Vector3.ZERO
	jump_buffer = 0
	coyote = 0
	gliding = false
	falls += 1

func set_playing(value: bool) -> void:
	playing = value
	jump_buffer = 0
	avatar.set_active(value)

func _physics_process(dt: float) -> void:
	if not playing:
		_update_camera()
		return
	elapsed += dt
	yaw += Input.get_axis("turn_left", "turn_right") * dt * 1.8
	var axis := Input.get_vector("left", "right", "forward", "back")
	var direction := Vector3(axis.x, 0, axis.y).rotated(Vector3.UP, yaw)
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	var was_grounded := is_on_floor()
	coyote = 0.12 if was_grounded else maxf(0, coyote - dt)
	jump_buffer = 0.14 if Input.is_action_just_pressed("jump") else maxf(0, jump_buffer - dt)
	if jump_buffer > 0 and coyote > 0 and not Input.is_action_pressed("dive"):
		velocity.y = 8.2
		jump_buffer = 0
		coyote = 0
		was_grounded = false
	elif was_grounded:
		velocity.y = -0.5
	else:
		var target := -18.0 if Input.is_action_pressed("dive") else (1.8 if Input.is_action_pressed("jump") else -2.4)
		var acceleration := 45.0 if Input.is_action_pressed("dive") else (6.0 if Input.is_action_pressed("jump") else 21.0)
		velocity.y = move_toward(velocity.y, target, acceleration * dt)
		if not Input.is_action_pressed("dive") and Vector2(position.x + 8, position.z + 4).length() <= 1.35 and position.y > 2.8 and position.y < 14.4:
			velocity.y = 14
	velocity.y = minf(velocity.y, (18.0 - position.y) / dt)
	# Explicit experimental 0.25m step aid; Godot does not share Rapier's autostep.
	if was_grounded and direction.length() > 0.1:
		var step_motion := Vector3(velocity.x, 0, velocity.z) * dt
		if test_move(global_transform, step_motion):
			var raised := global_transform.translated(Vector3.UP * 0.25)
			if not test_move(global_transform, Vector3.UP * 0.25) and not test_move(raised, step_motion):
				position.y += 0.25
	move_and_slide()
	gliding = not is_on_floor() and not Input.is_action_pressed("dive")
	if is_on_floor():
		landed_steps += 1
	avatar.rotation.y = yaw
	avatar.pose(is_on_floor(), gliding, Vector2(velocity.x, velocity.z).length())
	if position.y < -7 or absf(position.x - 2) > 25 or absf(position.z) > 23:
		respawn()
	if is_on_floor() and Vector2(position.x - GOAL.x, position.z - GOAL.z).length() < 1.25 and absf(position.y - 0.9 - GOAL.y) < 0.4:
		completed = true
	_update_camera()

func _update_camera() -> void:
	pivot.rotation.y = yaw
	arm.rotation.x = pitch
	arm.spring_length = 0.0 if first_person else 5.0
	avatar.visible = not first_person

func look(delta: Vector2) -> void:
	if not playing:
		return
	yaw -= delta.x * 0.004
	pitch = clampf(pitch - delta.y * 0.003, -0.95, 0.5)

func telemetry() -> Dictionary:
	return {"position": [position.x, position.y, position.z], "grounded": is_on_floor(), "gliding": gliding, "vertical_speed": velocity.y, "falls": falls, "completed": completed, "elapsed": elapsed, "landed_steps": landed_steps, "playing": playing, "first_person": first_person}
