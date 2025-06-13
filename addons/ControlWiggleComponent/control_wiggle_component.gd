class_name ControlWiggleComponent
extends Node

var initial_size: Vector2

var wiggle_tween: Tween
var wiggle_in_progress: bool = false

var scale_up_tween: Tween
var scale_down_tween: Tween

var parent

enum WiggleStrength { Low, Medium, High, Crazy }
var wiggle_rotation: float

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


func _ready() -> void:
    parent = get_parent()
    if !parent:
        printerr("ControlWiggleComponent neeeds a Control parent")
    call_deferred("set_initial_size")
    parent.mouse_entered.connect(on_mouse_entered)
    parent.mouse_exited.connect(on_mouse_exited)

    match wiggle_strength:
        WiggleStrength.Low:
            wiggle_rotation = PI/16
        WiggleStrength.Medium:
            wiggle_rotation = PI/8
        WiggleStrength.High:
            wiggle_rotation = PI/4
        WiggleStrength.Crazy:
            wiggle_rotation = PI/2




func on_mouse_entered():
    wiggle()

func on_mouse_exited():
    if should_increase_size:
        shrink()


func wiggle():
    if !wiggle_in_progress:
        wiggle_in_progress = true

        if scale_down_tween:
            scale_down_tween.kill() # to prevent two tweens from working on the same property at the same time, causing messed up behavior

        if should_increase_size:
            scale_up_tween = reset_tween(scale_up_tween)
            scale_up_tween.set_ease(Tween.EASE_OUT)
            scale_up_tween.set_trans(Tween.TRANS_EXPO)
            scale_up_tween.tween_property(parent, "scale", scale_up_size, scale_up_duration)


        if should_shake:
            print("wiggle in progress = " + str(wiggle_in_progress))
            wiggle_tween = reset_tween(wiggle_tween)
            wiggle_tween.tween_property(parent, "rotation", wiggle_rotation, wiggle_duration)
            wiggle_tween.chain()
            wiggle_tween.tween_property(parent, "rotation", 0, wiggle_duration)
            wiggle_tween.chain()
            wiggle_tween.tween_property(parent, "rotation", -wiggle_rotation, wiggle_duration)
            wiggle_tween.chain()
            wiggle_tween.tween_property(parent, "rotation", 0, wiggle_duration)

        get_tree().create_timer(max(scale_up_duration,wiggle_duration*4)).timeout.connect(func(): wiggle_in_progress = false)

func shrink():
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
    parent.pivot_offset = parent.size/2
