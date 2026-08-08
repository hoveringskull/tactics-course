class_name UISettingsMenu extends PanelContainer

signal back_requested

@onready var music_volume_slider: HSlider = %music_volume_slider
@onready var back_button: Button = %back_button

var _music_player: AudioStreamPlayer

func _ready() -> void:
	back_button.pressed.connect(back_requested.emit)
	
func bind_dependencies(music_player: AudioStreamPlayer) -> void:
	_music_player = music_player
	
func setup() -> void:
	music_volume_slider.value = _music_player.volume_db
	music_volume_slider.value_changed.connect(handle_music_volume_value_changed)
	
func get_focus() -> void:
	music_volume_slider.grab_focus()
	
func handle_music_volume_value_changed(value: float) -> void:
	_music_player.volume_db = value
