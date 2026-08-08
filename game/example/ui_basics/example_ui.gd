extends CanvasLayer

@onready var example_button: Button = %example_button
@onready var hooked_up_input: ExampleNameBox = %name_box

var _count = 0

func _ready() -> void:
	example_button.pressed.connect(handle_press)
	
	hooked_up_input.text_changed.connect(handle_text_change)
	
func handle_press() -> void:
	print("Pressed that buttton!")
	_count += 1
	example_button.text = str(_count)
	
func handle_text_change(new_string: String) -> void:
	print(new_string)
