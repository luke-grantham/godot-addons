class_name TransitionBehavior
extends RefCounted

signal transition_done()

var transition_name: String

func _init(_transition_name: String):
	transition_name = _transition_name

func execute_enter():
	if !TransitionManager.transition_done.is_connected(_on_transition_done):
		TransitionManager.transition_done.connect(_on_transition_done, ConnectFlags.CONNECT_ONE_SHOT)
	TransitionManager.to_game(transition_name)

func execute_exit():
	if !TransitionManager.transition_done.is_connected(_on_transition_done):
		TransitionManager.transition_done.connect(_on_transition_done, ConnectFlags.CONNECT_ONE_SHOT)
	TransitionManager.to_black(transition_name)

func _on_transition_done(transition_name: String, anim_name: String):
	transition_done.emit()
