extends Node

enum AudioBus {
    Master = 0,
    Music = 1,
    Sfx = 2
}

@export var volume_data: VolumeData

func _ready() -> void:
    if volume_data == null:
        printerr("Set volume_data in AudioManager")

    AudioServer.set_bus_volume_db(AudioBus.Master, linear_to_db(volume_data.master_volume_slider_setting))
    AudioServer.set_bus_volume_db(AudioBus.Music, linear_to_db(volume_data.music_volume_slider_setting))
    AudioServer.set_bus_volume_db(AudioBus.Sfx, linear_to_db(volume_data.sfx_volume_slider_setting))
