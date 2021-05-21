extends Control

const DYNAMIC_LOAD = true

const SOUNDS_PATH = "res://res/sounds"
const SOUND_BUTTON = preload("res://src/SoundButton.tscn")


onready var _buttons_container = $ScrollContainer/VBoxContainer/Buttons

func _ready() -> void:
	if DYNAMIC_LOAD:
		var dir := Directory.new()
		var err = dir.open(SOUNDS_PATH)
		if err == OK:
			var buttons := []
			dir.list_dir_begin()
			var file_name := dir.get_next()
			while file_name != "":
				if dir.file_exists(file_name):
					buttons.append(create_button(file_name))
				file_name = dir.get_next()
			print(buttons)
			buttons.sort_custom(self, "sorter")
			for button in buttons:
				_buttons_container.add_child(button)
				pass
		else:
			printerr("Error opening sounds path. ", err)



func create_button(sound_name: String) -> SceneTree:
	var res := ResourceLoader.load("%s/%s" % [SOUNDS_PATH, sound_name], "SoundData")
	var button = SOUND_BUTTON.instance()
	button.sound_data = res
	button.name = "%s-SoundButton" % sound_name.substr(0, 3)
	return button


func sorter(a: Control, b: Control) -> bool:
	return a.name < b.name
