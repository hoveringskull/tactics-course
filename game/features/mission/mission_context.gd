class_name MissionContext extends Node3D

func build() -> void:
	# Build any services or other variables that we need in this context
	pass
	
func bind_dependencies() -> void:
	# Pass in and bind any dependencies that this context needs from parent
	pass
	
func setup() -> void:
	# At this point, we have ALL dependencies resolved, and we can do any
	# setup that requires those, e.g. connect signals and use factories etc.
	pass
