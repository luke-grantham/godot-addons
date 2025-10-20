class_name PIDController
extends RefCounted

var kp: float
var ki: float
var kd: float

var _integral: float = 0.0
var _last_error: float = 0.0

func _init(_kp: float=0.0, _ki: float=0.0, _kd: float=0.0) -> void:
	kp = _kp
	ki = _ki
	kd = _kd

func get_output(error: float, delta: float) -> float:
	_integral += error * delta
	var derivative = (error - _last_error) / delta if delta > 0 else 0.0
	_last_error = error
	return error * kp + _integral * ki + derivative * kd


func reset(current_error):
	_last_error = current_error
