extends CanvasLayer
@export var leaderboard: Leaderboard
const start_hud: PackedScene=preload("res://hud/start_hud.tscn")
const score_row: PackedScene=preload("res://leaderboardRow.tscn")

func sort_asc(a,b):
	return a[1]>b[1]

func _ready():
	$leaderboard.play()
	leaderboard.scores.sort_custom(sort_asc)
	print(leaderboard.scores)
	for i in leaderboard.scores:
		var score_row_child=score_row.instantiate()
		score_row_child.user=i[0]
		score_row_child.score=i[1]
		$Container/Panel.add_child(score_row_child)
	
func _on_back_button_pressed():
	get_tree().change_scene_to_packed(start_hud)
