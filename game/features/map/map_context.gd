class_name MapContext extends Node3D

signal selected_mission_updated
signal mission_requested(mission: MissionData)

@onready var _ui_mission_list_panel: MissionListPanel = %mission_list_panel
@onready var _ui_mission_detail_panel: MissionDetailPanel = %mission_detail_panel

var _game_state: GameState

# UI State
var _selected_mission: MissionData
var selected_mission: MissionData:
	get: return _selected_mission
	set(value):
		if value == _selected_mission:
			return
		_selected_mission = value
		selected_mission_updated.emit(value)


func build() -> void:
	# Build any services or other variables that we need in this context
	pass
	
func bind_dependencies(game_state: GameState) -> void:
	# Pass in and bind any dependencies that this context needs from parent
	_game_state = game_state
	
func setup() -> void:
	# At this point, we have ALL dependencies resolved, and we can do any
	# setup that requires those, e.g. connect signals and use factories etc.
	_game_state.available_missions_changed.connect(_ui_mission_list_panel.populate_missions)
	_ui_mission_list_panel.populate_missions(_game_state.available_missions)
	_ui_mission_list_panel.mission_selection_requested.connect(func (mission: MissionData) -> void: selected_mission = mission)
	
	selected_mission_updated.connect(func (mission: MissionData) -> void: _ui_mission_detail_panel.current_mission = mission)
	_ui_mission_detail_panel.cancelled.connect(handle_details_cancelled)
	
	_ui_mission_detail_panel.enter_requested.connect(func () -> void: mission_requested.emit(selected_mission))
	
	_ui_mission_detail_panel.hide()
	_ui_mission_list_panel.get_focus(null)
	
func handle_details_cancelled() -> void:
	_ui_mission_list_panel.get_focus(selected_mission)
	selected_mission = null
