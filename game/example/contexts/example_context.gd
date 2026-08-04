class_name ExampleContext extends Node

enum ExampleSubContext {
	ContextOne,
	ContextTwo
}

var current_subcontext: ExampleSubContext
var current_subcontext_node: Node

@export var subcontext_one_scene: PackedScene

var cool_integer: int = 34

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

func mount_context_one() -> void:
	# Tear down old subcontext
	if current_subcontext_node:
		current_subcontext_node.queue_free()
		
		# You may need to do other tear down steps for your context depending on
		# what it does
	
	# Build new subcontext
	current_subcontext = ExampleSubContext.ContextOne
	current_subcontext_node = subcontext_one_scene.instantiate()
	add_child(current_subcontext_node)
	
	var subcontext_one: ExampleSubContextOne = current_subcontext_node as ExampleSubContextOne
	if subcontext_one == null:
		printerr("Missing subcontext")
		return
		
	subcontext_one.build()
	subcontext_one.bind_dependencies(cool_integer)
	subcontext_one.setup()	
	
