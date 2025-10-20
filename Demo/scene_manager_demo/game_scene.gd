extends Node2D

func _ready() -> void:
	$Button.pressed.connect(func(): SceneManager.load_scene(MyScenes.SceneId.MainMenu))
