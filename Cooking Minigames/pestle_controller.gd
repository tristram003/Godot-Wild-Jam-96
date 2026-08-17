extends CharacterBody3D

@export var mortar: Node3D
@export var max_radius: float = 0.15
@export var min_depth: float = 0.059
@export var max_depth: float = 2
@export var follow_speed: float = 10.0
@export var camera: Camera3D

var is_active: bool = false
var is_dragging: bool = false
var mortar_center: Vector3 = Vector3.ZERO
var current_target_pos: Vector3 = Vector3.ZERO
var start_pos: Vector3

func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	if mortar:
		mortar_center = mortar.global_position
	current_target_pos = global_position
	start_pos = current_target_pos


func toggle_active() -> void:
	is_active = !is_active
	if not is_active:
		hide()
		return
	if is_active:
		show()
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)


func _input(event: InputEvent) -> void:
	if not is_active:
		return
	if event.is_action_pressed("pickup"):
		is_dragging = true
	elif event.is_action_released("pickup"):
		is_dragging = false


func _process(delta: float) -> void:
	if not is_active:
		return
	if not is_dragging:
		if global_position != start_pos:
			current_target_pos = start_pos
			global_position = global_position.lerp(current_target_pos, follow_speed * delta)
			update_pestle_tilt(delta)
	
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var ray_origin: Vector3 = camera.project_ray_origin(mouse_pos)
	var ray_dir: Vector3 = camera.project_ray_normal(mouse_pos)
	
	var plane = Plane(Vector3.UP, mortar_center.y)
	var intersection = plane.intersects_ray(ray_origin, ray_dir)
	
	if intersection:
		var offset_from_center = intersection - mortar_center
		var horizontal_offset = Vector3(offset_from_center.x, 0, offset_from_center.z)
		
		if horizontal_offset.length() > max_radius:
			horizontal_offset = horizontal_offset.normalized() * max_radius
		
		var target_x = mortar_center.x + horizontal_offset.x
		var target_z = mortar_center.z + horizontal_offset.z
		var target_y = clamp(intersection.y, mortar_center.y + min_depth, mortar_center.y + max_depth)
		
		current_target_pos = Vector3(target_x, target_y, target_z)
		global_position = global_position.lerp(current_target_pos, follow_speed * delta)
		update_pestle_tilt(delta)


func update_pestle_tilt(delta: float) -> void:
	var movement_dir = (current_target_pos - global_position)
	var tilt_x = -movement_dir.z * 2.0
	var tilt_z = movement_dir.x * 2.0
	
	var target_rotation = Quaternion(Vector3.RIGHT, tilt_x) * Quaternion(Vector3.FORWARD, tilt_z)
	transform.basis =  transform.basis.slerp(Basis(target_rotation), 10.0 * delta)
