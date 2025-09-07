extends PanelContainer

@export var animation_to_play: String = "IrisWipe"

func _ready() -> void:
    $VBoxContainer/ToBlack.pressed.connect(func(): TransitionManager.to_black(animation_to_play))
    $VBoxContainer/ToGame.pressed.connect(func(): TransitionManager.to_game(animation_to_play))
    $VBoxContainer/SetBlack.pressed.connect(func(): TransitionManager.set_black(animation_to_play))
    $VBoxContainer/SetGame.pressed.connect(func(): TransitionManager.set_game(animation_to_play))
