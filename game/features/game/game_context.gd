class_name GameContext extends Node3D

signal menu_requested

@export var map_context_scene: PackedScene
@export var mission_context_scene: PackedScene
@export var explore_context_scene: PackedScene

# TEMP
@export var mission_params: MissionParameters

@onready var menu_button: Button = %menu
@onready var map_button: Button = %map_button
@onready var mission_button: Button = %mission_button
@onready var explore_button: Button = %explore_button


var _current_context: Node
var _game_state: GameState
var _mission_factory: MissionFactory

func build() -> void:
	_game_state = GameState.new()
	_mission_factory = MissionFactory.new()

	
func bind_dependencies() -> void:
	# Pass in and bind any dependencies that this context needs from parent
	pass
	
func setup() -> void:
	# At this point, we have ALL dependencies resolved, and we can do any
	# setup that requires those, e.g. connect signals and use factories etc.
	menu_button.pressed.connect(menu_requested.emit)
	map_button.pressed.connect(mount_map)
	mission_button.pressed.connect(mount_mission)
	explore_button.pressed.connect(mount_explore)
	
	initialize_game_state()

	mount_map()
	
func mount_map() -> void:
	if _current_context:
		_current_context.queue_free()
		
	_current_context = map_context_scene.instantiate()
	var context: MapContext = _current_context as MapContext
	if not context:
		printerr("No map context found")
		return
		
	add_child(context)
	context.build()
	context.bind_dependencies(_game_state)
	context.setup()
	
	context.mission_requested.connect(handle_transition_to_mission)
		
func mount_mission() -> void:
	if _current_context:
		_current_context.queue_free()
		
	_current_context = mission_context_scene.instantiate()
	var context: MissionContext = _current_context as MissionContext
	if not context:
		printerr("No mission context found")
		return
		
	add_child(context)
	context.build()
	context.bind_dependencies()
	context.setup()
	
func mount_explore() -> void:
	if _current_context:
		_current_context.queue_free()
		
	_current_context = explore_context_scene.instantiate()
	var context: ExploreContext = _current_context as ExploreContext
	if not context:
		printerr("No explore context found")
		return
		
	add_child(context)
	context.build()
	context.bind_dependencies()
	context.setup()

func initialize_game_state() -> void:
	_game_state.available_missions = []
	
	for i: int in range(0, 4):
		_game_state.available_missions.append(_mission_factory.generate_random(mission_params))
	
	
	_game_state.available_missions_changed.emit(_game_state.available_missions)
	
func handle_transition_to_mission(mission: MissionData) -> void:
	_game_state.current_mission = mission
	mount_mission()
