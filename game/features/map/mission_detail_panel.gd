class_name MissionDetailPanel extends PanelContainer

signal cancelled
signal enter_requested

@onready var title_label: Label = %title
@onready var description_label: Label = %description
@onready var enter_button: Button = %enter_button
@onready var cancel_button: Button  = %cancel_button

var _current_mission: MissionData
var current_mission: MissionData:
	get: return _current_mission
	set(value):
		if value == current_mission:
			return
			
		_current_mission = value
		
		if _current_mission == null:
			hide()
		else:
			title_label.text = _current_mission.name
			description_label.text = _current_mission.description
			show()
			get_focus()

func _ready() -> void:
	cancel_button.pressed.connect(cancelled.emit)
	enter_button.pressed.connect(enter_requested.emit)
	
func get_focus() -> void:
	enter_button.grab_focus()
