class_name TweenedTransition
extends MyTransition

var tween: Tween
var shader_material: ShaderMaterial

@export var progress_shader_param_name: String = "progress"

@export_group("to_black settings")
@export var to_black_progress_value: float = 100.0
@export var to_black_duration: float = 1.0
@export var to_black_trans: Tween.TransitionType = Tween.TRANS_LINEAR
@export var to_black_ease: Tween.EaseType = Tween.EASE_OUT

@export_group("to_game settings")
@export var to_game_progress_value: float = 0.0
@export var to_game_duration: float = 1.0
@export var to_game_trans: Tween.TransitionType = Tween.TRANS_LINEAR
@export var to_game_ease: Tween.EaseType = Tween.EASE_OUT

func _ready() -> void:
	shader_material = material as ShaderMaterial

func to_black():
	tween = reset_tween(tween)
	tween.finished.connect(func(): transition_done.emit(name, "to_black") )
	tween.tween_property(self, "material:shader_parameter/%s" % progress_shader_param_name, to_black_progress_value, to_black_duration)
	tween.set_trans(to_black_trans)
	tween.set_ease(to_black_ease)


func to_game():
	tween = reset_tween(tween)
	tween.finished.connect(func(): transition_done.emit(name, "to_game") )
	tween.tween_property(self, "material:shader_parameter/%s" % progress_shader_param_name, to_game_progress_value, to_game_duration)
	tween.set_trans(to_game_trans)
	tween.set_ease(to_game_ease)

func set_black():
	shader_material.set_shader_parameter(progress_shader_param_name, to_black_progress_value)

func set_game():
	shader_material.set_shader_parameter(progress_shader_param_name, to_game_progress_value)

func check_setup():
	pass

func reset_tween(t: Tween) -> Tween:
	if t:
		t.stop()
	return create_tween()
