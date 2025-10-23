extends MenuEffect

var tween: Tween
@export var activation_time: float = 1.0

@export var fade_in_trans: Tween.TransitionType = Tween.TRANS_BACK
@export var fade_out_trans: Tween.TransitionType = Tween.TRANS_BACK
@export var fade_in_ease: Tween.EaseType = Tween.EASE_OUT
@export var fade_out_ease: Tween.EaseType = Tween.EASE_OUT

func _ready() -> void:
	super()

	if parent.visible:
		set_active()
	else:
		set_inactive()

func activate():
	activate_started.emit()
	parent.show()

	tween = MyUtil.reset_tween(self, tween)
	tween.set_trans(fade_in_trans)
	tween.set_ease(fade_in_ease)
	tween.tween_property(parent, "modulate:a", 1.0, activation_time)
	tween.finished.connect(
		func():
			activate_finished.emit()
	)
	activate_finished.emit()

func deactivate():
	deactivate_started.emit()

	tween = MyUtil.reset_tween(self, tween)
	tween.set_trans(fade_out_trans)
	tween.set_ease(fade_out_ease)
	tween.tween_property(parent, "modulate:a", 0.0, activation_time)
	tween.finished.connect(
		func():
			parent.hide()
			deactivate_finished.emit()
	)


func set_active():
	parent.modulate.a = 1.0
	parent.show()

func set_inactive():
	parent.modulate.a = 0.0
	parent.hide()
