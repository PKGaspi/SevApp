extends Control

const SOUNDS_PATH = "res://res/sounds"
const SOUND_BUTTON = preload("res://src/SoundButton.tscn")

onready var _buttons_container = $ScrollContainer/VBoxContainer/Buttons

func _ready() -> void:
	var dir := Directory.new()
	var err = dir.open(SOUNDS_PATH)
	if err == OK:
		dir.list_dir_begin()
		var file := dir.get_next()
		while file != "":
			if dir.file_exists(file):
				var res := ResourceLoader.load("%s/%s" % [SOUNDS_PATH, file], "SoundData")
				print(res)
				add_button(res)
			file = dir.get_next()
	else:
		printerr("Error opening sounds path. ", dir.open(SOUNDS_PATH))



func add_button(res: SoundData):
	var button = SOUND_BUTTON.instance()
	button.sound_data = res
	_buttons_container.add_child(button)
