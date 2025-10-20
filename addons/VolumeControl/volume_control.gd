@tool
class_name VolumeControl
extends GridContainer


@export var sound_on_texture: Texture
@export var sound_off_texture: Texture
@export var audio_bus: AudioManager.AudioBus
@export var labelText: String

var volume_data: VolumeData

@onready var volume_slider: HSlider = %VolumeSlider
@onready var mute_button: Button = %MuteButton
@onready var icon: TextureRect = %Icon

# we don't want to play the sfx noise the first two times it is set because that's during scene setup
var sfx_set_counter: int = 0

func _ready() -> void:
	volume_data = AudioManager.volume_data
	%Label.text = labelText
	if Engine.is_editor_hint():
		return
	volume_slider_setup()
	mute_button.pressed.connect(on_mute_button_pressed)
	check_mute_icon_logic()
	force_update()


func volume_slider_setup():
	volume_slider.max_value = 1.0

	if !volume_slider.value_changed.is_connected(_on_value_changed):
		volume_slider.value_changed.connect(_on_value_changed)

	match audio_bus:
		AudioManager.AudioBus.Music:
			volume_slider.value = volume_data.music_volume_slider_setting
		AudioManager.AudioBus.Sfx:
			volume_slider.value = volume_data.sfx_volume_slider_setting
		AudioManager.AudioBus.Master:
			volume_slider.value = volume_data.master_volume_slider_setting




func on_mute_button_pressed():
	volume_slider.value = 0.0

func check_mute_icon_logic():
	match audio_bus:
		AudioManager.AudioBus.Music:
			if volume_data.music_volume_slider_setting == 0.0:
				icon.texture = sound_off_texture
				return
		AudioManager.AudioBus.Sfx:
			if volume_data.sfx_volume_slider_setting == 0.0:
				icon.texture = sound_off_texture
				return
		AudioManager.AudioBus.Master:
			if volume_data.master_volume_slider_setting == 0.0:
				icon.texture = sound_off_texture
				return

	icon.texture = sound_on_texture


## If the value of the slider is 0 and the slider is set to 0 on startup it will not trigger _on_value_changed
## this happens when we set the slider to 0 and save the game and then load the game
func force_update():
	match audio_bus:
		AudioManager.AudioBus.Music:
			_on_value_changed(volume_data.music_volume_slider_setting)
		AudioManager.AudioBus.Sfx:
			_on_value_changed(volume_data.sfx_volume_slider_setting)
		AudioManager.AudioBus.Master:
			_on_value_changed(volume_data.master_volume_slider_setting)

func _on_value_changed(v: float) -> void:
	AudioServer.set_bus_volume_db(audio_bus, linear_to_db(v))


	match audio_bus:
		AudioManager.AudioBus.Music:
			volume_data.music_volume_slider_setting = v
		AudioManager.AudioBus.Sfx:
			if sfx_set_counter < 2:
				sfx_set_counter += 1
			else:
				%SfxTest.play()

			volume_data.sfx_volume_slider_setting = v
		AudioManager.AudioBus.Master:
			volume_data.master_volume_slider_setting = v

	check_mute_icon_logic()
