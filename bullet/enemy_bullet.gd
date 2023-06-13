extends Area2D
signal damage

func _process(delta):
	position.y+=300*delta
	
func _on_area_entered(area):
	if area.is_in_group("Ship"):
		damage.emit()
		queue_free()
	elif area.is_in_group("bullet"):
		queue_free()
	elif area.is_in_group("shield_piece"):
		area.life-=1
		if area.life==0:
			area.queue_free()
		queue_free()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
