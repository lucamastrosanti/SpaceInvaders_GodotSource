extends Area2D
class_name Bullet
signal score(type)
signal recharge
signal ufo

func _process(delta):
	position.y-=500*delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	recharge.emit()

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		score.emit(area.type)
		queue_free()
		area.queue_free()
		recharge.emit()
	elif area.is_in_group("enemy_bullet"):
		queue_free()
		recharge.emit()
	elif area.is_in_group("shield_piece"):
		area.life-=1
		if area.life==0:
			area.queue_free()
		queue_free()
		recharge.emit()
	elif area.is_in_group("ufo"):
		recharge.emit()
		queue_free()
		area.queue_free()
		score.emit(randi_range(10,30))
		ufo.emit()
