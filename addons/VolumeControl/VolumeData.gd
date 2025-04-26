class_name VolumeData
extends Resource

# set initial setting low for game jam games
# so we don't blow people's ears out
# it is set in the Resource because the volume slider is a node that could be loaded multiple times
# but we only want to do this once
@export var first_time_setting_music_volume: bool = true
@export var first_time_setting_sfx_volume: bool = true
@export var first_time_setting_master_volume: bool = true

@export var music_volume_slider_setting: float = 0.5
@export var sfx_volume_slider_setting: float = 0.5
@export var master_volume_slider_setting: float = 0.5

