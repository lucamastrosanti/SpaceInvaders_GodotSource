extends HBoxContainer
@export var user: String ="":
	set(value):
		user=value
		$name.text=user
@export var score: int=0:
	set(value):
		score=value
		$score.text=str(score)
