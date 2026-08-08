class_name MainMenuContext extends Node3D

signal start_game_requested

@onready var ui_main_menu: UIMainMenu = %ui_main_menu
@onready var ui_settings_menu: UISettingsMenu = %ui_settings_menu

var _music_player: AudioStreamPlayer

func build() -> void:
	# Build any services or other variables that we need in this context
	pass
	
func bind_dependencies(music_player: AudioStreamPlayer) -> void:
	_music_player = music_player
	
	ui_settings_menu.bind_dependencies(_music_player)
	
func setup() -> void:
	# At this point, we have ALL dependencies resolved, and we can do any
	# setup that requires those, e.g. connect signals and use factories etc.
	
	ui_main_menu.play_requested.connect(start_game_requested.emit)
	ui_main_menu.quit_requested.connect(handle_quit)
	ui_main_menu.load_requested.connect(handle_show_saved_games)
	ui_main_menu.settings_requested.connect(handle_show_settings_menu)
	ui_settings_menu.back_requested.connect(handle_show_main_menu)
	
	ui_settings_menu.setup()
	
	handle_show_main_menu()
	
	

func handle_quit() -> void:
	get_tree().quit()
	
func handle_show_saved_games() -> void:
	print("Not implemented yet")
	
func handle_show_main_menu() -> void:
	ui_main_menu.show()
	ui_settings_menu.hide()
	ui_main_menu.get_focus()

func handle_show_settings_menu() -> void:
	ui_settings_menu.show()
	ui_main_menu.hide()
	ui_settings_menu.get_focus()
