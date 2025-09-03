extends Node


@export var scene_data: Array[SceneData]

var scene_dict: Dictionary = {}

func _ready() -> void:
    for d in scene_data:
        scene_dict[d.scene_id] = d

func load_scene(scene_id: MyScenes.SceneId):
    var data: SceneData = scene_dict[scene_id]

    if data.exiting_transition_name != "":
        print("SceneManager ::: Switching to %s with transition" % MyUtil.enum_name(MyScenes.SceneId, scene_id))
        data.transition_done.connect(_run_entering_behavior.bind(data), ConnectFlags.CONNECT_ONE_SHOT)
        data.run_exiting_behavior()
    else:
        print("SceneManager ::: Switching to %s" % MyUtil.enum_name(MyScenes.SceneId, scene_id))
        get_tree().change_scene_to_packed(data.scene)

func _run_entering_behavior(data: SceneData):
    get_tree().change_scene_to_packed(data.scene)
    if data.entering_transition_name != "":
        data.run_entering_behavior()
