class_name PauseMenu
extends PanelContainer

@export var pause_action: String = "pause"
@export var should_capture_mouse_on_close: bool = false
@export var focused_node_on_pause: Control

func _ready() -> void:
    hide()
    %ResumeButton.pressed.connect(func(): toggle_pause())

func _process(delta: float) -> void:
    if Input.is_action_just_pressed(pause_action):
        toggle_pause()

func toggle_pause():
    get_tree().paused = !get_tree().paused

    if get_tree().paused:
        print("PauseMenu ::: Paused")
        show()
        if focused_node_on_pause:
            focused_node_on_pause.grab_focus()
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    else:
        print("PauseMenu ::: Unpaused")
        hide()
        if should_capture_mouse_on_close:
            Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


