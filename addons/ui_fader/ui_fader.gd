class_name UiFader
extends Node

## Start fading the parent Control if the watched value hasn't changed in this amount of time
@export_range(0.0, 60.0, 0.1, "or_greater", "suffix:s")
var fade_after: float = 3.0
## How long it takes for the fade to go from visible to invisible
@export_range(0.0, 8.0, 0.1, "or_greater", "suffix:s")
var fade_duration: float = 2.0
## The parent signal with a single argument. This signal should fire every time the argument changes, giving the new value
@export var value_update_signal: String
## Should the parent control start in a visible state
@export var start_visible: bool = true

var time_since_value_update: float = 0.0
var watched_value

var parent: Control


func _ready() -> void:
	parent = get_parent()
	if !parent or !(parent is Control):
		printerr("UiFader must have a Control node as a parent")

	if parent and !parent.has_signal(value_update_signal):
		printerr("UiFader's parent (%s) must have signal named matching export variable value_update_signal which is currently set to %s" % [ parent.name,value_update_signal ])
	elif parent:
		parent.connect(value_update_signal, watched_value_updated)

	if start_visible:
		parent.modulate.a = 1.0
	else:
		parent.modulate.a = 0.0



func watched_value_updated(new_value):
	if new_value != watched_value:
		watched_value = new_value
		time_since_value_update = 0.0
		parent.modulate.a = 1.0


func _process(delta: float) -> void:
	time_since_value_update = clamp(time_since_value_update+delta,0.0, fade_after)

	if time_since_value_update >= fade_after:
		parent.modulate.a = clamp(parent.modulate.a-(1.0/(fade_duration+0.01)*delta), 0.0, 1.0)
