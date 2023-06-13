extends HBoxContainer
const ShipLife: PackedScene= preload("res://hud/ship_life.tscn")
@export var number=3

func _ready():
	spawn()

func spawn():
	if number>5:
		number=5
	for x in range (number):
		var Shiplife_child := ShipLife.instantiate()
		add_child(Shiplife_child)
