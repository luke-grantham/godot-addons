class_name ExpSmoothController
extends RefCounted

var speed: float  # higher = faster smoothing

func _init(_speed: float = 5.0) -> void:
	speed = _speed

func update(current: Vector2, target: Vector2, delta: float) -> Vector2:
	return current + (target - current) * (1.0 - exp(-speed * delta))
