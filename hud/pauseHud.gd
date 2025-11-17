extends CanvasLayer
signal resume

func _on_quit_button_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_file("res://main/main_menu.tscn")

func _on_resume_button_pressed():
	resume.emit()
