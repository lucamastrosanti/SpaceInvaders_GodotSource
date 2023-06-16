extends CanvasLayer
signal start
const main: PackedScene =preload("res://main/main.tscn")
const leaderboard: PackedScene =preload("res://leaderboard.tscn")
var passages=0
var data_file_path="user://Leaderboard.json"

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
		var json_file = FileAccess.open(data_file_path,FileAccess.READ)
		var json_file_text= json_file.get_as_text()
		var parse= JSON.parse_string(json_file_text)
		json_file.close()
		parse["username"]=$NameHud/LineEdit.text
		json_file = FileAccess.open(data_file_path, FileAccess.WRITE)
		json_file.store_string(JSON.stringify(parse, "  ", true))
		json_file.close()
		get_tree().change_scene_to_packed(main)
	else:
		$NameHud/Error.show()
		
func _on_passage_timer_timeout():
	passages=1
	$PassageTimer.stop()

func _on_leaderboard_button_pressed():
	get_tree().change_scene_to_packed(leaderboard)

func _on_leti_pressed():
	OS.shell_open("https://github.com/letilau")

func _on_luca_pressed():
	OS.shell_open("https://github.com/lucamastrosanti")
