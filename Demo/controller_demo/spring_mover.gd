extends Sprite2D

var move_target: Vector2 = Vector2(200.0,200.0)
var c: SpringController

func _ready() -> void:
    c = SpringController.new(200.0, 15.0)


func _process(delta: float) -> void:
    move_target = get_global_mouse_position()
    global_position = c.update(global_position, move_target, delta)
