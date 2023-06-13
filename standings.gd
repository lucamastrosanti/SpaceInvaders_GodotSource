extends Resource
class_name Leaderboard
@export var scores: Array=[]

func add_score(name:String,score:int):
	scores.append([name,score])
