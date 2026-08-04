class_name MapContext extends Node3D

var _game_state: GameState

func build() -> void:
	# Build any services or other variables that we need in this context
	pass
	
func bind_dependencies(game_state: GameState) -> void:
	# Pass in and bind any dependencies that this context needs from parent
	_game_state = game_state
	
func setup() -> void:
	# At this point, we have ALL dependencies resolved, and we can do any
	# setup that requires those, e.g. connect signals and use factories etc.
	print(_game_state.money)
