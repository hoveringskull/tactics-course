class_name MapCamera extends Camera3D


@export var focus_duration: float = 0.25

var _default_position: Vector3
var _current_tween: Tween

var _focus_mission: MissionData
var focus_mission: MissionData:
	get: return _focus_mission
	set(value):
		if value == _focus_mission:
			return
		_focus_mission = value
		if _focus_mission == null:
			animate_focus(_default_position)
		else:
			animate_focus(_focus_mission.map_pin_location + Vector3(3, 3, 0))
			
func _ready() -> void:
	_default_position = position
	
func animate_focus(target: Vector3) -> void:
	if _current_tween:
		_current_tween.kill()
		
	_current_tween = get_tree().create_tween()
	_current_tween.set_ease(Tween.EASE_IN)
	_current_tween.tween_property(self, "position", target, focus_duration)

func animate_focus_in() -> void:
	if _current_tween:
		_current_tween.kill()
	
	_current_tween = get_tree().create_tween()
	
	_current_tween.tween_property(self, "position", focus_mission.map_pin_location, focus_duration)
	await _current_tween.finished
	

	
