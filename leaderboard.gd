extends CanvasLayer
const start_hud: PackedScene=preload("res://hud/start_hud.tscn")
const score_row: PackedScene=preload("res://leaderboardRow.tscn")
var data_file_path="user://Leaderboard.json"

func sort_asc(a,b):
	return a["score"]>b["score"]

func _ready():
	$leaderboard.play()
	
	var json_file = FileAccess.open(data_file_path,FileAccess.READ)
	var json_file_text= json_file.get_as_text()
	var parse=JSON.parse_string(json_file_text)
	json_file.close()
	(parse["leaderboard"] as Array).sort_custom(sort_asc)
	json_file=FileAccess.open(data_file_path,FileAccess.WRITE)
	json_file.store_string(JSON.stringify(parse,"",true))
	
	for i in parse["leaderboard"]:
		var score_row_child=score_row.instantiate()
		score_row_child.user=i["username"]
		score_row_child.score=i["score"]
		$Container/Panel.add_child(score_row_child)

func _on_back_button_pressed():
	get_tree().change_scene_to_packed(start_hud)
