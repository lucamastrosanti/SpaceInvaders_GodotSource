extends Node

var json = {
		"username":"",
		"score":0,
		"leaderboard":[{
			"username":"theprogrammer",
			"score":16
		}, {
			"username":"RedFoxy",
			"score":-10
		}]
	}
var data_file_path="user://Leaderboard.json"

func _ready():
	json=file_load(data_file_path)
	
func file_load(path: String):
	if FileAccess.file_exists(path)==false:
		FileAccess.open("user://Leaderboard.json", FileAccess.WRITE).store_line("")
		FileAccess.open("user://Leaderboard.json", FileAccess.WRITE).close()
	var DataFile=FileAccess.open(path,FileAccess.READ)
	var json_text=JSON.parse_string(DataFile.get_as_text())
	DataFile.close()
	if json_text==null:
		DataFile=FileAccess.open(path,FileAccess.WRITE)
		var json_string=JSON.stringify(json)
		DataFile.store_string(json_string)
		DataFile.close()
