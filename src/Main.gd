extends Control

const SOUND_BUTTON = preload("res://src/SoundButton.tscn")
const FONT = preload("res://res/font.tres")
const LANGUAGE_SECTION_CONTAINER = preload("res://src/LanguageSectionContainer.tscn")

const SOUNDS_PATH = "res://res/sounds"


onready var _buttons_containers_node = $VBoxContainer/ScrollContainer/VBoxContainer
onready var _scroll_container_node = $VBoxContainer/ScrollContainer


func _ready() -> void:
	# Remove scroll bar.
	_scroll_container_node.get_v_scrollbar().rect_scale.x = 0
	
	# Open sounds directory.
	var dir := Directory.new()
	var err = dir.open(SOUNDS_PATH)
	if err != OK:
		printerr("Error opening sounds directory. ", err)
		return
	
	# Create array of arrays of sounds, separated by language
	var sound_groups := []
	for lang in global.languages:
		sound_groups.append([])
	
	# Load resources
	err = dir.list_dir_begin()
	if err != OK:
		printerr("Error listing sounds directory. ", err)
		return
		
	var file_name := dir.get_next()
	while file_name != "":
		if dir.file_exists(file_name):
			var button = create_button(file_name)
			sound_groups[button.sound_data.language].append(button)
		file_name = dir.get_next()
	
	# Add containers per language
	var i = 0
	for sound_group in sound_groups:
		sound_group.sort_custom(self, "sorter")
		# Create a new container for this language
		var container = LANGUAGE_SECTION_CONTAINER.instance()
		_buttons_containers_node.add_child(container)
		container.set_title(global.language_names[i])
		container.name = "%sSectionContainer" % global.language_names[i]
		
		for sound in sound_group:
			container.add_button(sound)
			
		i += 1




func create_button(sound_name: String) -> SceneTree:
	var res := ResourceLoader.load("%s/%s" % [SOUNDS_PATH, sound_name])
	var button = SOUND_BUTTON.instance()
	button.sound_data = res
	button.name = "%s-SoundButton" % sound_name.substr(0, 3)
	return button


func sorter(a: Control, b: Control) -> bool:
	return a.name < b.name
