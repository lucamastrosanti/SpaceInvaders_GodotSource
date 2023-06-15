extends CanvasLayer
const start_hud: PackedScene =preload("res://hud/start_hud.tscn")
signal resume

func _on_quit_button_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_packed(start_hud)

func _on_resume_button_pressed():
	resume.emit()

