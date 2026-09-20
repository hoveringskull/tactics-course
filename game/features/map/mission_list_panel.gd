class_name MissionListPanel extends PanelContainer

signal mission_selection_requested(mission: MissionData)

@onready var list_node: Node = %available_mission_list

var _missions: Array[MissionData]

func populate_missions(missions: Array[MissionData]) -> void:
	_missions = missions
	clear_children()
	
	for mission: MissionData in missions:
		var button: Button = Button.new()
		button.text = mission.name
		button.autowrap_mode = TextServer.AUTOWRAP_WORD
		button.pressed.connect(mission_selection_requested.emit.bind(mission))
		list_node.add_child(button)

func clear_children() -> void:
	for child: Node in list_node.get_children():
		child.free()
		
func get_focus(mission: MissionData) -> void:
	var mission_index: int = _missions.find(mission)
	if mission_index == -1:
		mission_index = 0
	var btn: Button = list_node.get_child(mission_index) as Button
	if btn:
		btn.grab_focus()
