class_name SoundData
extends Resource

const GLOBAL = preload("res://src/Global.gd")

export var title: String
export(String, MULTILINE) var transcript: String
export(GLOBAL.Languages) var language: int
export var stream: AudioStream

func _ready() -> void:
	pass
