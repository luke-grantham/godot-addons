@tool
class_name ReactiveButtonComponent
extends Node


## Enable/Disable all functionality
@export var enabled: bool = true
## How long it takes for the Button to change size
@export var scale_duration: float = 0.2
## How big to scale up the Button when hovered
@export var scale_up_size: Vector2 = Vector2(1.1,1.1)
## How small to scale down the Button when pressed
@export var pressed_scale: Vector2 = Vector2(0.9,0.9)

@onready var hover_sound_player: AudioStreamPlayer = $HoverSoundPlayer
@onready var pressed_sound_player: AudioStreamPlayer = $PressedSoundPlayer

var scale_tween: Tween

var initial_size: Vector2

var is_mouse_inside_button: bool = false

var parent: Button

func _get_configuration_warnings() -> PackedStringArray:
    var result := []
    var p: Node = get_parent()
    if !p or p is not Button:
        result.append("ReactiveButtonComponent needs a Button parent")

    return result

func _ready() -> void:
    if !Engine.is_editor_hint():
        parent = get_parent()
        call_deferred("set_initial_size")
        parent.mouse_entered.connect(on_mouse_entered)
        parent.mouse_exited.connect(on_mouse_exited)
        parent.button_down.connect(on_button_down)
        parent.button_up.connect(on_button_up)
        parent.pressed.connect(on_button_pressed)

        parent.visibility_changed.connect(on_parent_visibility_changed)


func on_mouse_entered():
    is_mouse_inside_button = true
    if enabled:
        grow()
        hover_sound_player.play()

func on_mouse_exited():
    is_mouse_inside_button = false
    if enabled:
        to_normal_size()

func on_button_down():
    if enabled:
        shrink()

func on_button_up():
    if enabled:
        if is_mouse_inside_button:
            grow()
        else:
            to_normal_size()

func on_button_pressed():
    if enabled:
        pressed_sound_player.play()

func grow():
    scale_tween = reset_tween(scale_tween)
    scale_tween.set_ease(Tween.EASE_OUT)
    scale_tween.set_trans(Tween.TRANS_EXPO)
    scale_tween.tween_property(parent, "scale", scale_up_size, scale_duration)

func to_normal_size():
    scale_tween = reset_tween(scale_tween)
    scale_tween.set_ease(Tween.EASE_OUT)
    scale_tween.set_trans(Tween.TRANS_EXPO)
    scale_tween.tween_property(parent, "scale", Vector2.ONE, scale_duration)

func shrink():
    scale_tween = reset_tween(scale_tween)
    scale_tween.set_ease(Tween.EASE_OUT)
    scale_tween.set_trans(Tween.TRANS_EXPO)
    scale_tween.tween_property(parent, "scale", pressed_scale, scale_duration)

func reset_tween(t: Tween) -> Tween:
    if t:
        t.stop()
    return create_tween()


func on_parent_visibility_changed():
    # Sometimes when hiding and showing menus this is needed to set the proper size
    if parent.visible:
        call_deferred("set_initial_size")

func set_initial_size():
    initial_size = parent.size
    parent.pivot_offset = parent.size/2.0
