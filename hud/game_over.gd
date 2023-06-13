extends CanvasLayer
const main: PackedScene=preload("res://main/main.tscn")
const start_hud: PackedScene=preload("res://hud/start_hud.tscn")

func _ready():
	$game_over.play()

func _on_menu_pressed():
	get_tree().change_scene_to_packed(start_hud)

func _on_restart_pressed():
	get_tree().change_scene_to_packed(main)
