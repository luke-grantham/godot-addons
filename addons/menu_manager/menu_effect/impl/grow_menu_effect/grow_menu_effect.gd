extends MenuEffect

var tween: Tween
@export var activation_time: float = 1.0

@export var grow_trans: Tween.TransitionType = Tween.TRANS_BACK
@export var shrink_trans: Tween.TransitionType = Tween.TRANS_BACK
@export var grow_ease: Tween.EaseType = Tween.EASE_OUT
@export var shrink_ease: Tween.EaseType = Tween.EASE_OUT

func _ready() -> void:
	super()
	parent.pivot_offset = parent.size/2.0

	if parent.visible:
		set_active()
	else:
		set_inactive()

func activate():
	activate_started.emit()
	parent.show()

	tween = MyUtil.reset_tween(self, tween)
	tween.set_trans(grow_trans)
	tween.set_ease(grow_ease)
	tween.tween_property(parent, "scale", Vector2.ONE, activation_time)
	tween.finished.connect(
		func():
			activate_finished.emit()
	)
	activate_finished.emit()

func deactivate():
	deactivate_started.emit()

	tween = MyUtil.reset_tween(self, tween)
	tween.set_trans(shrink_trans)
	tween.set_ease(shrink_ease)
	tween.tween_property(parent, "scale", Vector2.ZERO, activation_time)
	tween.finished.connect(
		func():
			parent.hide()
			deactivate_finished.emit()
	)


func set_active():
	parent.scale = Vector2.ONE
	parent.show()

func set_inactive():
	parent.scale = Vector2.ZERO
	parent.hide()
