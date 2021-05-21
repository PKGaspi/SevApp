class_name SoundData
extends Resource

export var id: int
export var title: String
export(String, MULTILINE) var transcript: String
export(global.languages) var language: int
export var stream: AudioStream

func _ready() -> void:
	pass
