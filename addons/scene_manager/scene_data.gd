class_name SceneData
extends Resource

signal transition_done()

@export var scene: PackedScene
@export var scene_id: MyScenes.SceneId
@export var entering_transition_name: String = ""
@export var exiting_transition_name: String = ""
@export var transition_behavior: Script

var active_behavior: TransitionBehavior

func run_entering_behavior():
    if transition_behavior:
        active_behavior = transition_behavior.new(entering_transition_name)
        active_behavior.transition_done.connect(func(): transition_done.emit())
        if active_behavior.has_method("execute_enter"):
            active_behavior.execute_enter()

func run_exiting_behavior():
    if transition_behavior:
        active_behavior = transition_behavior.new(exiting_transition_name)
        active_behavior.transition_done.connect(func(): transition_done.emit())
        if active_behavior.has_method("execute_exit"):
            active_behavior.execute_exit()
