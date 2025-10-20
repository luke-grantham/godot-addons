extends Button

func _ready() -> void:
	pressed.connect(
		func():
			get_tree().reload_current_scene()
	)
