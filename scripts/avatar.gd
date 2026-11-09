class_name WoodlandAvatar
extends Node3D
## Original unchanged project GLBs. Animation poses and socket are imported, not rebuilt.
var body_model: Node3D
var wings: Node3D
var body_animation: AnimationPlayer
var wing_animation: AnimationPlayer
var current_clip := ""
var wing_clip := ""
var speed_scale_value := 1.0

func _ready() -> void:
	body_model = load("res://assets/fox.glb").instantiate()
	add_child(body_model)
	body_animation = find_animation(body_model)
	wings = load("res://assets/angel.glb").instantiate()
	wings.scale = Vector3.ONE * 0.65
	var socket := body_model.find_child("WingSocket", true, false)
	if socket:
		socket.add_child(wings)
	else:
		add_child(wings)
		wings.position = Vector3(0, 0.85, 0.35)
	wing_animation = find_animation(wings)
	pose(true, false, 0.0)

func find_animation(root: Node) -> AnimationPlayer:
	if root is AnimationPlayer:
		return root
	for child in root.get_children():
		var found := find_animation(child)
		if found:
			return found
	return null

func actual_clip(player: AnimationPlayer, suffix: String) -> String:
	if not player:
		return ""
	for name in player.get_animation_list():
		if String(name).get_file() == suffix:
			return String(name)
	return ""

func pose(grounded: bool, flying: bool, speed: float) -> void:
	if not body_animation:
		return
	var wanted := "AvatarIdle" if grounded and speed < 0.15 else ("AvatarRun" if grounded else "AvatarGlide")
	var clip := actual_clip(body_animation, wanted)
	if not clip.is_empty() and current_clip != clip:
		body_animation.get_animation(clip).loop_mode = Animation.LOOP_LINEAR
		body_animation.play(clip, 0.12)
		current_clip = clip
	body_animation.speed_scale = clampf(speed / 5.0, 0.35, 2.0) if wanted == "AvatarRun" else 1.0
	if wing_animation:
		var next_wing := actual_clip(wing_animation, "WingGlide" if flying else "WingFold")
		if next_wing != wing_clip and not next_wing.is_empty():
			wing_animation.get_animation(next_wing).loop_mode = Animation.LOOP_LINEAR if flying else Animation.LOOP_NONE
			wing_animation.play(next_wing, 0.12)
			wing_clip = next_wing

func set_active(active: bool) -> void:
	if body_animation:
		body_animation.speed_scale = speed_scale_value if active else 0.0
	if wing_animation:
		wing_animation.speed_scale = 1.0 if active else 0.0
