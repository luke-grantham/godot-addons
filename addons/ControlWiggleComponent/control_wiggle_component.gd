@tool
class_name ControlWiggleComponent
extends Node

signal wiggle_done

var initial_size: Vector2

var wiggle_tween: Tween
var wiggle_in_progress: bool = false

var scale_up_tween: Tween
var scale_down_tween: Tween

var parent

enum WiggleStrength { Low, Medium, High, Crazy }
var wiggle_rotation: float

## Enable/Disable all functionality
@export var enabled: bool = true
## How much the control node rotates on wiggle
@export var wiggle_strength: WiggleStrength = WiggleStrength.Low
## duration of the shaking motion
@export var wiggle_duration: float = 0.04
## turn on/off size scaling
@export var should_increase_size: bool = true
## turn on/off shaking motion
@export var should_shake: bool = true
## How long it takes for the Control node to increase in size
@export var scale_up_duration: float = 0.30
## How long it takes for the Control node to shrink
@export var shrink_duration: float = 1.0
## How big to scale up the Control node
@export var scale_up_size: Vector2 = Vector2(1.2,1.2)
## Wiggle on focus (for controller support)
@export var wiggle_on_focus: bool = true

var is_growing: bool = false
var is_mouse_inside_button: bool = false

func _get_configuration_warnings() -> PackedStringArray:
    var result := []
    var p: Node = get_parent()
    if !p or p is not Control:
        result.append("ControlWiggleComponent neeeds a Control parent")

    return result

func _ready() -> void:
    if !Engine.is_editor_hint():
        parent = get_parent()
        call_deferred("set_initial_size")
        parent.mouse_entered.connect(on_mouse_entered)
        parent.mouse_exited.connect(on_mouse_exited)
        if wiggle_on_focus:
            parent.focus_entered.connect(on_focus_entered)
            parent.focus_exited.connect(on_mouse_exited)

        parent.visibility_changed.connect(on_parent_visibility_changed)

        match wiggle_strength:
            WiggleStrength.Low:
                wiggle_rotation = PI/16
            WiggleStrength.Medium:
                wiggle_rotation = PI/8
            WiggleStrength.High:
                wiggle_rotation = PI/4
            WiggleStrength.Crazy:
                wiggle_rotation = PI/2


func on_parent_visibility_changed():
    # Sometimes when hiding and showing menus this is needed to set the proper size
    if parent.visible:
        call_deferred("set_initial_size")


func on_mouse_entered():
    is_mouse_inside_button = true
    if enabled:
        wiggle()

func on_mouse_exited():
    is_mouse_inside_button = false
    if enabled and should_increase_size:
        shrink()

func on_focus_entered():
    if enabled: # since focus and mouse do the same thing, delay focus so it doesn't trigger twice
        call_deferred("wiggle")

func wiggle():
    if !wiggle_in_progress:
        $HoverSound.play()
        wiggle_in_progress = true

        if scale_down_tween:
            scale_down_tween.kill() # to prevent two tweens from working on the same property at the same time, causing messed up behavior

        if should_increase_size:
            scale_up_tween = reset_tween(scale_up_tween)
            scale_up_tween.set_ease(Tween.EASE_OUT)
            scale_up_tween.set_trans(Tween.TRANS_EXPO)
            scale_up_tween.tween_property(parent, "scale", scale_up_size, scale_up_duration)


        if should_shake:
            wiggle_tween = reset_tween(wiggle_tween)
            wiggle_tween.tween_property(parent, "rotation", wiggle_rotation, wiggle_duration)
            wiggle_tween.chain()
            wiggle_tween.tween_property(parent, "rotation", 0, wiggle_duration)
            wiggle_tween.chain()
            wiggle_tween.tween_property(parent, "rotation", -wiggle_rotation, wiggle_duration)
            wiggle_tween.chain()
            wiggle_tween.tween_property(parent, "rotation", 0, wiggle_duration)

        var on_wiggle_done: Callable = func ():
            wiggle_in_progress = false
            wiggle_done.emit()

        get_tree().create_timer(max(scale_up_duration,wiggle_duration*4)).timeout.connect(on_wiggle_done)

func shrink():
    if wiggle_in_progress:
        await wiggle_done
    if is_mouse_inside_button:
        return

    scale_down_tween = reset_tween(scale_down_tween)
    scale_down_tween.set_ease(Tween.EASE_OUT)
    scale_down_tween.set_trans(Tween.TRANS_ELASTIC)
    scale_down_tween.tween_property(parent, "scale", Vector2(1.0,1.0), shrink_duration)


func reset_tween(t: Tween) -> Tween:
    if t:
        t.stop()
    return create_tween()

func set_initial_size():
    initial_size = parent.size
    parent.pivot_offset = parent.size/2.0
