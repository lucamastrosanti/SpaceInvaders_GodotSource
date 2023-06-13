class_name Shield_piece
extends Area2D
@export var life=5
@export var dimensions: Vector2
@export var flip = false

func _ready():
	dimensions=$CollisionShape2D.shape.get_rect().size

func _process(_delta):
	$AnimatedSprite2D.set_flip_h(flip)
	$AnimatedSprite2D.set_animation(str(life))
