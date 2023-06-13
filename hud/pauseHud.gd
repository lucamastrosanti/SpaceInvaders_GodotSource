extends CanvasLayer
const start_hud: PackedScene =preload("res://hud/start_hud.tscn")
signal resume
var passages=0

func _process (_delta):
	if Input.is_action_pressed("esc") and passages==1:
		_on_resume_button_pressed()
		passages=0

func _on_quit_button_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_packed(start_hud)

func _on_resume_button_pressed():
	resume.emit()

func _on_passages_timer_timeout():
	passages=1
	$PassagesTimer.stop()
