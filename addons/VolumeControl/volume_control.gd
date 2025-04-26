@tool
class_name VolumeControl
extends GridContainer

enum AudioBus {
    Master = 0,
    Music = 1,
    Sfx = 2
}

@export var sound_on_texture: Texture
@export var sound_off_texture: Texture
@export var audio_bus: AudioBus
@export var labelText: String

# Resource sharing through export variables only works inside the same scene
# gotta preload from res or load a version previously saved to user://
# or have a resource manager autoload storing each resource
var volume_data: VolumeData = preload("res://addons/VolumeControl/VolumeData.tres") as VolumeData

@onready var volume_slider: HSlider = %VolumeSlider
@onready var mute_button: Button = %MuteButton
@onready var icon: TextureRect = %Icon

var first_time_setting_volume: bool = true

func _ready() -> void:
    %Label.text = labelText
    if Engine.is_editor_hint():
        return
    volume_slider_setup()
    mute_button.pressed.connect(on_mute_button_pressed)


func volume_slider_setup():
    match audio_bus:
        AudioBus.Music:
            volume_slider.max_value = 1.0
        AudioBus.Sfx:
            volume_slider.max_value = 1.0
        AudioBus.Master:
            volume_slider.max_value = 1.0

    if !volume_slider.value_changed.is_connected(_on_value_changed):
        volume_slider.value_changed.connect(_on_value_changed)

    match audio_bus:
        AudioBus.Music:
            if volume_data.first_time_setting_music_volume:
                print("init setting to %s" % str(volume_slider.max_value / 10.0)) # init)
                volume_slider.value = volume_slider.max_value / 10.0 # init
                volume_data.first_time_setting_music_volume = false
            else:
                print("setting to %s" % str(volume_data.music_volume_slider_setting))
                volume_slider.value = volume_data.music_volume_slider_setting
        AudioBus.Sfx:
            if volume_data.first_time_setting_sfx_volume:
                volume_slider.value = volume_slider.max_value / 10.0 #init
                volume_data.first_time_setting_sfx_volume = false
            else:
                volume_slider.value = volume_data.sfx_volume_slider_setting
        AudioBus.Master:
            if volume_data.first_time_setting_master_volume:
                volume_slider.value = volume_slider.max_value / 10.0 #init
                volume_data.first_time_setting_master_volume = false
            else:
                volume_slider.value = volume_data.master_volume_slider_setting




func on_mute_button_pressed():
    volume_slider.value = 0.0


func _on_value_changed(v: float) -> void:
    AudioServer.set_bus_volume_db(audio_bus, linear_to_db(v))

    if v == 0.0:
        icon.texture = sound_off_texture
    else:
        icon.texture = sound_on_texture

    match audio_bus:
        AudioBus.Music:
            volume_data.music_volume_slider_setting = v
        AudioBus.Sfx:
            if first_time_setting_volume:
                first_time_setting_volume = false
            else:
                %SfxTest.play()

            volume_data.sfx_volume_slider_setting = v
        AudioBus.Master:
            volume_data.master_volume_slider_setting = v
