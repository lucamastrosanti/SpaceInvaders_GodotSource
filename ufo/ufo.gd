extends Area2D
@export var vel=220

func _ready():
	#now ufo is an animated sprite
	$ufo_Sprite.play()

func _process(delta):
	position.x+=vel*delta
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
