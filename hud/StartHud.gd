extends CanvasLayer
signal start
const main: PackedScene =preload("res://main/main.tscn")
const leaderboard: PackedScene =preload("res://leaderboard.tscn")
@export var nickname: username
var passages=0

func _ready():
	$"start hud".play()
	$NameHud.hide()
	$Credits.hide()
	$Menu/ScoreIndex/enemy3.play()
	$Menu/ScoreIndex/enemy2.play()
	$Menu/ScoreIndex/enemy1.play()
	
func _process(_delta):
	if Input.is_action_pressed("enter") and passages==0:
		_on_start_button_pressed()
		
	if Input.is_action_pressed("enter") and passages==1:
		_on_name_button_pressed()
	
func _on_credits_button_pressed():
	$Credits.show()
	$Menu.hide()
	
func _on_esc_button_pressed():
	$Credits.hide()
	$Menu.show()

func _on_start_button_pressed():
	$PassageTimer.start()
	$NameHud.show()
	$Menu.hide()

func _on_name_button_pressed():
	if $NameHud/LineEdit.text != "":
		nickname.user=$NameHud/LineEdit.text
		ResourceSaver.save(nickname,"res://username.tres")
		get_tree().change_scene_to_packed(main)
	else:
		$NameHud/Error.show()
		
func _on_passage_timer_timeout():
	passages=1
	$PassageTimer.stop()

func _on_leaderboard_button_pressed():
	get_tree().change_scene_to_packed(leaderboard)
