class_name ExampleNameBox extends MarginContainer

signal text_changed(string: String)

@onready var input: LineEdit = %input

func _ready() -> void:
	input.text_changed.connect(handle_text_change)
	
func handle_text_change(new_string: String) -> void:
	text_changed.emit(new_string)
