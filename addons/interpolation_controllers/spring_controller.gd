class_name SpringController
extends RefCounted

var stiffness: float
var damping: float
var velocity: Vector2 = Vector2.ZERO

func _init(_stiffness: float = 200.0, _damping: float = 20.0) -> void:
    stiffness = _stiffness
    damping = _damping

func update(current: Vector2, target: Vector2, delta: float) -> Vector2:
    var force = (target - current) * stiffness - velocity * damping
    velocity += force * delta
    return current + velocity * delta
