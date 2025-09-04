class_name SceneData
extends Resource

signal transition_done()

@export var scene: PackedScene
@export var scene_id: MyScenes.SceneId
@export var entering_transition_name: String = ""
@export var exiting_transition_name: String = ""

var active_behavior: TransitionBehavior

func run_entering_behavior():
    active_behavior = TransitionBehavior.new(entering_transition_name)
    active_behavior.transition_done.connect(func(): transition_done.emit(), ConnectFlags.CONNECT_ONE_SHOT)
    if active_behavior.has_method("execute_enter"):
        active_behavior.execute_enter()

func run_exiting_behavior():
    active_behavior = TransitionBehavior.new(exiting_transition_name)
    active_behavior.transition_done.connect(func(): transition_done.emit(), ConnectFlags.CONNECT_ONE_SHOT)
    if active_behavior.has_method("execute_exit"):
        active_behavior.execute_exit()
