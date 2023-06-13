extends Node2D
const shield: PackedScene= preload("res://shield piece/shield_piece.tscn")
const shield_laterale: PackedScene = preload("res://shield piece/laterale/laterale.tscn")
const shield_down: PackedScene = preload("res://shield piece/in basso/in basso.tscn")

func _ready():
	for y in range(3):
		for x in range(4):
			if ((x==1 and y==0) or (x==2 and y==0)):
				pass
			elif ((x==3 and y==2) or (x==0 and y==2)):
				var shield_piece:=shield_laterale.instantiate()
				add_child(shield_piece)
				shield_piece.position=position-(Vector2(-1.5,-0.5)+Vector2(x,y))*shield_piece.dimensions
				if x==3:
					shield_piece.flip=true
			elif ((x==1 and y==1) or (x==2 and y==1)):
				var shield_piece:=shield_down.instantiate()
				add_child(shield_piece)
				shield_piece.position=position-(Vector2(-1.5,-0.5)+Vector2(x,y))*shield_piece.dimensions
				if x==2:
					shield_piece.flip=true
			else:
				var shield_piece:=shield.instantiate()
				add_child(shield_piece)
				shield_piece.position=position-(Vector2(-1.5,-0.5)+Vector2(x,y))*shield_piece.dimensions
