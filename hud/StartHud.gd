extends CanvasLayer
@warning_ignore("unused_signal")
signal start
const main: PackedScene =preload("res://main/main.tscn")
const leaderboard: PackedScene =preload("res://leaderboard.tscn")
var passages=0
var data_file_path="user://Leaderboard.json"

func _ready():
	$"start hud".play()
	$NameHud.hide()
	$HowToPlay.hide()
	$Credits.hide()
	$Menu/ScoreIndex/enemy3.play()
	$Menu/ScoreIndex/enemy2.play()
	$Menu/ScoreIndex/enemy1.play()
	$Menu/ScoreIndex/ufo2.play() #now ufo is an animated sprite
	
func _process(_delta):
	if Input.is_action_pressed("enter") and passages==0:
		_on_start_button_pressed()
		
	if Input.is_action_pressed("enter") and passages==1:
		_on_name_button_pressed()
	
func _on_credits_button_pressed():
	$Credits.show()
	$Menu.hide()
	$HowToPlay.hide()
	
func _on_esc_button_pressed():
	$Credits.hide()
	$Menu.show()
	$HowToPlay.hide()

func _on_start_button_pressed():
	$PassageTimer.start()
	$NameHud.show()
	$Menu.hide()

func _on_how_to_play_button_pressed():
	$Menu.hide()
	$HowToPlay.show()
	
func _on_esc_htp_pressed():
	$Menu.show()
	$HowToPlay.hide()

func _on_name_button_pressed():
	var userName = $NameHud/LineEdit.text
	
	if userName == "": # as before, stop without username
		$NameHud/Error.text="*You need to choose a username*"
		$NameHud/Error.show()
		
	elif userName.length() > 9: #limits the name lenght to 9 for graphics reason
		$NameHud/Error.text="*You can put maximum 9 characters*" 
		$NameHud/Error.show()
	
	elif userName != "": #if the username is correct
		var json_file = FileAccess.open(data_file_path,FileAccess.READ)
		var json_file_text= json_file.get_as_text()
		var parse= JSON.parse_string(json_file_text)
		json_file.close()
		parse["username"]=$NameHud/LineEdit.text
		json_file = FileAccess.open(data_file_path, FileAccess.WRITE)
		json_file.store_string(JSON.stringify(parse, "  ", true))
		json_file.close()
		get_tree().change_scene_to_packed(main)


func _on_passage_timer_timeout():
	passages=1
	$PassageTimer.stop()

func _on_leaderboard_button_pressed():
	get_tree().change_scene_to_packed(leaderboard)

func _on_leti_pressed():
	OS.shell_open("https://github.com/letilau")

func _on_luca_pressed():
	OS.shell_open("https://github.com/lucamastrosanti")
