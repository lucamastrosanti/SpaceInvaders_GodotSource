extends Area2D
var vel
@onready var polygon: PackedVector2Array=$ship_CollisionShape.polygon
@onready var speed =400
@export var life:int=3
signal game_over
signal not_immune
var limit

func _ready():
	position = Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y*7.35/8)
	limit=polygon[2].distance_to(polygon[1])/2

func _process(delta):
	vel=0
	if life==0:
		game_over.emit()
	if Input.is_action_pressed("destra"):
		vel+=speed
	if Input.is_action_pressed("sinistra"):
		vel+=-speed
	position.x+=vel*delta
	position.x=clamp(position.x, limit, get_viewport_rect().size.x-limit)

func start():
	show()
	position = Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y*8.5/9)

func _on_invincible_timer_timeout():
	not_immune.emit()
