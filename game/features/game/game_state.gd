class_name GameState extends Resource

signal available_missions_changed(missions: Array[MissionData])

@export var available_missions: Array[MissionData]
@export var current_mission: MissionData
