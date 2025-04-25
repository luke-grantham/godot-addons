extends PanelContainer


func _ready() -> void:
    TransitionManager.transition_done.connect(on_transition_done)
    %ToBlack.pressed.connect(func(): TransitionManager.to_black("IrisWipe"))
    %ToGame.pressed.connect(func(): TransitionManager.to_game("IrisWipe"))
    %SetBlack.pressed.connect(func(): TransitionManager.set_black("IrisWipe"))
    %SetGame.pressed.connect(func(): TransitionManager.set_game("IrisWipe"))

func on_transition_done(transition_name, animation_name):
    print("Transition %s , Animation %s DONE" % [transition_name, animation_name])
