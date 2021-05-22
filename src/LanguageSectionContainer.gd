extends VBoxContainer

onready var _title_node := $MarginContainer/MarginContainer/TitleLabel
onready var _buttons := $Buttons


func set_title(value: String) -> void:
	_title_node.text = value

func add_button(button: Control) -> void:
	_buttons.add_child(button)
