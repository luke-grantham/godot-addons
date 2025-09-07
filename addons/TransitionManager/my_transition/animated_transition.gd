class_name AnimatedTransition
extends MyTransition

func _ready() -> void:
    check_setup()
    $AnimationPlayer.animation_finished.connect(func(anim_name): transition_done.emit(name, anim_name))

func to_black():
    $AnimationPlayer.play(to_black_animation)

func to_game():
    $AnimationPlayer.play(to_game_animation)

func set_black():
    $AnimationPlayer.play(to_black_animation)
    $AnimationPlayer.seek($AnimationPlayer.current_animation_length, true)

func set_game():
    $AnimationPlayer.play(to_game_animation)
    $AnimationPlayer.seek($AnimationPlayer.current_animation_length, true)


func check_setup():
    if !has_node("AnimationPlayer"):
        printerr("Transition %s needs AnimationPlayer" % name)
    else:
        var ap := $AnimationPlayer as AnimationPlayer
        if !ap.has_animation(to_black_animation):
            printerr("AnimationPlayer needs anmiation named %s" % to_black_animation)
        if !ap.has_animation(to_game_animation):
            printerr("AnimationPlayer needs anmiation named %s" % to_game_animation)
