extends Control

export var sound_data: Resource = null

onready var _sound_node = $Sound
onready var _label_node = $VBoxContainer/Label

func _ready() -> void:
	if sound_data != null:
		assert(sound_data is SoundData)
		_sound_node.stream = sound_data.stream
		_label_node.text = sound_data.title
