extends ParallaxBackground
@export var vel:=Vector2(50,0)

func _process(delta):
	scroll_base_offset -= vel*delta
