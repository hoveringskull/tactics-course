class_name UIMainMenu extends PanelContainer

signal play_requested
signal load_requested
signal settings_requested
signal quit_requested

@onready var play_button: Button = %play_button
@onready var load_button: Button = %load_button
@onready var settings_button: Button = %settings_button
@onready var quit_button: Button = %quit_button

func _ready() -> void:
	play_button.pressed.connect(play_requested.emit)
	load_button.pressed.connect(load_requested.emit)
	settings_button.pressed.connect(settings_requested.emit)
	quit_button.pressed.connect(quit_requested.emit)
	

func get_focus() -> void:
	play_button.grab_focus()
