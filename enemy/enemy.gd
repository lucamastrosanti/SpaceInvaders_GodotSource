extends Area2D
class_name Enemy
@onready var _shape: Vector2
@onready var collision: CollisionShape2D = $enemy_CollisionShape
@export var enemy_Gun: Node2D
@export var size: Vector2:
	set(value):
		size=value
		resize()
@export var type: int = 0:
	set(value):
		type=value
		$enemy_Sprite.set_animation(str(value))
		$enemy_Sprite.play(str(value))
signal game_over

func _ready():
	enemy_Gun=$enemy_Gun
	resize()

func _process(_delta):
	if global_position.y>get_viewport_rect().size.y*7.35/8:
		game_over.emit()

func resize():
	if collision != null:
		_shape=collision.shape.get_rect().size
		var scale_x=size.x/_shape.x
		var _scale=Vector2(scale_x, scale_x)
		scale=_scale

func _on_area_entered(area):
	if area.is_in_group("shield_piece"):
		area.queue_free()
	if area.is_in_group("Ship"):
		game_over.emit()
