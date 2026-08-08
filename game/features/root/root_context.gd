class_name RootContext extends Node3D

@export var main_menu_context_scene: PackedScene
@export var game_context_scene: PackedScene

var _music_player: AudioStreamPlayer

var _current_context: Node

func _ready() -> void:
	build()
	bind_dependencies()
	setup()

func build() -> void:
	# Build any services or other variables that we need in this context
	_music_player = AudioStreamPlayer.new()
	# TODO: add a music track
	_music_player.autoplay = true
	add_child(_music_player)
	
func bind_dependencies() -> void:
	# Pass in and bind any dependencies that this context needs from parent
	pass
	
func setup() -> void:
	# At this point, we have ALL dependencies resolved, and we can do any
	# setup that requires those, e.g. connect signals and use factories etc.
	mount_main_menu()
	
func mount_main_menu() -> void:
	if _current_context:
		_current_context.queue_free()
		
	_current_context = main_menu_context_scene.instantiate()
	var menu_context: MainMenuContext = _current_context as MainMenuContext
	if not menu_context:
		printerr("No menu context found")
		return
		
	add_child(menu_context)
	menu_context.build()
	menu_context.bind_dependencies(_music_player)
	menu_context.setup()
	
	menu_context.start_game_requested.connect(mount_game)
	
func mount_game() -> void:
	if _current_context:
		_current_context.queue_free()
		
	_current_context = game_context_scene.instantiate()
	var game_context: GameContext = _current_context as GameContext
	if not game_context:
		printerr("No game context found")
		return
		
	add_child(game_context)
	game_context.build()
	game_context.bind_dependencies()
	game_context.setup()
	
	game_context.menu_requested.connect(mount_main_menu)
