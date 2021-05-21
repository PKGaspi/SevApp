extends Control

const SOUND_BUTTON = preload("res://src/SoundButton.tscn")
const FONT = preload("res://res/font.tres")

const SOUNDS_PATH = "res://res/sounds"


onready var _buttons_containers_node = $VBoxContainer/ScrollContainer/VBoxContainer
onready var _scroll_container_node = $VBoxContainer/ScrollContainer


func _ready() -> void:
	var dir := Directory.new()
	var err = dir.open(SOUNDS_PATH)
	if err != OK:
		printerr("Error opening sounds directory. ", err)
		return
	
	# Create array of arrays of buttons, separated by language
	var containers := []
	for lang in global.languages:
		containers.append([])
	
	# Load resources
	err = dir.list_dir_begin()
	if err != OK:
		printerr("Error listing sounds directory. ", err)
		return
		
	var file_name := dir.get_next()
	while file_name != "":
		if dir.file_exists(file_name):
			var button = create_button(file_name)
			containers[button.sound_data.language].append(button)
		file_name = dir.get_next()
	
	# Add containers per language
	var i = 0
	for container in containers:
		container.sort_custom(self, "sorter")
		# Create a new container for this language
		var vbox = VBoxContainer.new()
		vbox.name = "%sVBoxContainer" % global.language_names[i]
		var margin = MarginContainer.new()
		margin.add_constant_override("margin_bottom", 10)
		margin.add_constant_override("margin_top", 10)
		margin.name = "LanguageMarginContainer"
		var label = Label.new()
		label.text = global.language_names[i]
		label.add_font_override("font", FONT)
		label.valign = Label.VALIGN_CENTER
		label.align = Label.ALIGN_CENTER
		label.name = "LanguageLabel"
		var grid = GridContainer.new()
		grid.columns = 3
		grid.name = "ButtonsGrid"
		# Add nodes to the scene
		_buttons_containers_node.add_child(vbox)
		vbox.add_child(margin)
		margin.add_child(label)
		vbox.add_child(grid)
		i += 1
		for button in container:
			grid.add_child(button)




func create_button(sound_name: String) -> SceneTree:
	var res := ResourceLoader.load("%s/%s" % [SOUNDS_PATH, sound_name])
	var button = SOUND_BUTTON.instance()
	button.sound_data = res
	button.name = "%s-SoundButton" % sound_name.substr(0, 3)
	return button


func sorter(a: Control, b: Control) -> bool:
	return a.name < b.name
