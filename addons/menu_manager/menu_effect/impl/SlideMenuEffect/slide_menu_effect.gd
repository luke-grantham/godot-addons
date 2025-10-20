extends MenuEffect

var tween: Tween

var initial_position: Vector2
var off_screen_position: Vector2

enum SlideOutDirection {
	Right,
	Left,
	Up,
	Down
}

@export var slide_out_direction: SlideOutDirection
@export_group("Transition Duration")
@export var slide_out_time: float = 1.0
@export var slide_in_time: float = 1.0
@export_group("Transitions Settings")
@export var slide_in_trans: Tween.TransitionType = Tween.TRANS_BACK
@export var slide_out_trans: Tween.TransitionType = Tween.TRANS_BACK
@export var slide_in_ease: Tween.EaseType = Tween.EASE_OUT
@export var slide_out_ease: Tween.EaseType = Tween.EASE_OUT


func _ready() -> void:
	super()
	initial_position = parent.global_position


	match slide_out_direction:
		SlideOutDirection.Right:
			off_screen_position = Vector2(
				initial_position.x + (get_viewport().get_visible_rect().size.x-initial_position.x),
				initial_position.y
			)
		SlideOutDirection.Left:
			off_screen_position = Vector2(0.0-parent.get_rect().size.x, initial_position.y)
		SlideOutDirection.Up:
			off_screen_position = Vector2(initial_position.x, 0.0-parent.get_rect().size.y)
		SlideOutDirection.Down:
			off_screen_position = Vector2(
				initial_position.x,
				initial_position.y + (get_viewport().get_visible_rect().size.y-initial_position.y),
			)

	if parent.visible:
		set_active()
	else:
		set_inactive()


func activate():
	activate_started.emit()
	parent.show()

	tween = MyUtil.reset_tween(self, tween)
	tween.set_trans(slide_in_trans)
	tween.set_ease(slide_in_ease)
	tween.tween_property(parent, "global_position", initial_position, slide_in_time)
	tween.finished.connect(
		func():
			activate_finished.emit()
	)


func deactivate():
	deactivate_started.emit()
	tween = MyUtil.reset_tween(self, tween)
	tween.set_trans(slide_out_trans)
	tween.set_ease(slide_out_ease)
	tween.tween_property(parent, "global_position", off_screen_position, slide_out_time)
	tween.finished.connect(
		func():
			parent.hide()
			deactivate_finished.emit()
	)

func set_active():
	parent.global_position = initial_position


func set_inactive():
	parent.global_position = off_screen_position
