extends VBoxContainer

onready var _title_node := $MarginContainer/MarginContainer/TitleLabel
onready var _buttons := $Buttons
onready var _hide_button_node := $MarginContainer/HideButton


func set_title(value: String) -> void:
	_title_node.text = value

func add_button(button: Control) -> void:
	_buttons.add_child(button)


func _on_HideButton_toggled(button_pressed: bool) -> void:
	_buttons.visible = !button_pressed
	_hide_button_node.text = "Show" if button_pressed else "Hide"
