class_name MyTransition
extends CanvasItem

signal transition_done(transition_name: String, anim_name: String)

var to_black_animation: StringName = StringName("to_black")
var to_game_animation: StringName  = StringName("to_game")

func _ready() -> void:
    pass

func to_black():
    pass

func to_game():
    pass

func set_black():
    pass

func set_game():
    pass


func check_setup():
    pass
