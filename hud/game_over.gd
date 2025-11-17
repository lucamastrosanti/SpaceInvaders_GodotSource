extends CanvasLayer

func _ready():
	$game_over.play()

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://main/main_menu.tscn")

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://main/main.tscn")
