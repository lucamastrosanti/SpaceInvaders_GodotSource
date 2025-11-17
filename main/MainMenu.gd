extends Control
const start_hud: PackedScene =preload("res://hud/start_hud.tscn")

func _ready():
	get_tree().change_scene_to_packed(start_hud)
