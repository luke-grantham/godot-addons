extends Node


@export var scene_data: Array[SceneData]

var scene_dict: Dictionary = {}

var running: bool = false

func _ready() -> void:
    for d in scene_data:
        scene_dict[d.scene_id] = d

func load_scene(scene_id: MyScenes.SceneId):
    var data: SceneData = scene_dict[scene_id]

    if !running and data.exiting_transition_name != "":
        running = true
        print("SceneManager ::: Switching to %s with transition" % MyUtil.enum_name(MyScenes.SceneId, scene_id))
        data.transition_done.connect(_run_entering_behavior.bind(data), ConnectFlags.CONNECT_ONE_SHOT)
        data.run_exiting_behavior()
    elif !running:
        print("SceneManager ::: Switching to %s" % MyUtil.enum_name(MyScenes.SceneId, scene_id))
        get_tree().change_scene_to_packed(data.scene)
        running = false

func _run_entering_behavior(data: SceneData):
    get_tree().change_scene_to_packed(data.scene)
    if data.entering_transition_name != "":
        data.transition_done.connect(on_done_entering, ConnectFlags.CONNECT_ONE_SHOT)
        data.run_entering_behavior()

func on_done_entering():
    running = false

