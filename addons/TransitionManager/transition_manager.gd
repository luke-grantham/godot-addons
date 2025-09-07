extends CanvasLayer

signal transition_done(transition_name: String, anim_name: String)

@export var should_print_done_messages: bool = true

func _ready() -> void:
    for child in get_children():
        if child is MyTransition:
            child.transition_done.connect(
                func(t_name, a_name):
                    transition_done.emit(t_name, a_name)
                    if should_print_done_messages:
                        print("TransitionManager ::: Done :: %s.%s" % [t_name, a_name])
            )

func to_black(transition_name: NodePath):
    var t := get_node_or_null(transition_name)
    if t:
        t.to_black()
    else:
        print_transition_error(transition_name)


func to_game(transition_name: NodePath):
    var t := get_node_or_null(transition_name)
    if t:
        t.to_game()
    else:
        print_transition_error(transition_name)

func set_black(transition_name: NodePath):
    var t := get_node_or_null(transition_name)
    if t:
        t.set_black()
    else:
        print_transition_error(transition_name)

func set_game(transition_name: NodePath):
    var t := get_node_or_null(transition_name)
    if t:
        t.set_game()
    else:
        print_transition_error(transition_name)

func print_transition_error(t_name: String):
    printerr("TransitionManager couldn't find transition_name %s" % t_name)

