class_name MainMenuCamera3D
extends Camera3D

var initial_x: float
var initial_y: float

## How far the screen can rotate up and down
@export_range(0.0, 15.0, 0.1, "radians_as_degrees")
var max_pitch: float = 5.0

## How far the screen can rotate left and right
@export_range(0.0, 15.0, 0.1, "radians_as_degrees")
var max_yaw: float = 5.0

func _ready() -> void:
	initial_x = rotation.x
	initial_y = rotation.y

func _process(delta: float) -> void:
	var viewport:Viewport = get_viewport()
	var mouse_position: Vector2 = viewport.get_mouse_position()

	var normalized_x: float = mouse_position.x / viewport.get_visible_rect().size.x
	var normalized_y: float = mouse_position.y / viewport.get_visible_rect().size.y

	# remap from 0,1 to -1,1 so 0 is center
	var centered_x: float = -(normalized_x - 0.5) * 2.0
	var centered_y: float = -(normalized_y - 0.5) * 2.0

	rotation.y = lerp_angle(rotation.y, initial_y+(centered_x*max_yaw), delta)
	rotation.x = lerp_angle(rotation.x, initial_x+(centered_y*max_pitch), delta)
