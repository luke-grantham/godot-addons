@tool
class_name ConfirmButton
extends Button

signal confirmed()

enum State {
    Initial,
    Pressed,
    Confirmed
}

var state: State = State.Initial

@export var initial_text: String = "do the thing"
@export var pressed_text: String = "are you sure?"
@export var confirmed_text: String = "done!"


func _ready() -> void:
    text = initial_text
    pressed.connect(on_pressed)


func on_pressed():
    match state:
        State.Initial:
            text = pressed_text
            state = State.Pressed
        State.Pressed:
            text = confirmed_text
            state = State.Confirmed
        State.Confirmed:
            text = initial_text
            state = State.Initial
            confirmed.emit()
