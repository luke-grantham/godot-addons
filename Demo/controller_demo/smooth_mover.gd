extends Sprite2D

var move_target: Vector2 = Vector2(200.0,200.0)
var c: ExpSmoothController

func _ready() -> void:
	c = ExpSmoothController.new(5.0)


func _process(delta: float) -> void:
#    if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
	move_target = get_global_mouse_position()
		#c.reset((move_target-global_position).length())

	global_position = c.update(global_position, move_target, delta)


