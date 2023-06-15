extends Node2D 
const bullet_child : PackedScene = preload("res://bullet/bullet.tscn")
const enemy_bullet_child: PackedScene = preload("res://bullet/enemy_bullet.tscn")
const shields_child: PackedScene = preload("res://Shields/shields.tscn")
const game_over: PackedScene = preload("res://hud/game_over.tscn")
const main: PackedScene =preload("res://main/main.tscn")
const ufo: PackedScene =preload("res://ufo/ufo.tscn")
var charger=0
var immune=0
signal invulnerable
var hack=0
var data_file_path = "user://Leaderboard.json"

func _on_ready_timer_timeout():
	$game_play.play()
	$get_readyAudio.stop()
	$UfoTimer.set_wait_time(randi_range(20, 40))
	$UfoTimer.start()
	$get_ready.hide()
	$group_enemy.show()
	$group_enemy/ShootTimer.start()
	$group_enemy/SliceTimer.start()
	$get_ready/ReadyTimer.stop()
	charger=1
	for x in range (4):
		var shield:= shields_child.instantiate()
		add_child(shield)
		shield.position=Vector2(get_viewport_rect().size.x*17.5/20-x*get_viewport_rect().size.x*5/20,get_viewport_rect().size.y*7/9)


func _ready():
	var json_file = FileAccess.open(data_file_path,FileAccess.READ)
	var json_file_text= json_file.get_as_text()
	var parse=JSON.parse_string(json_file_text)
	$PlayHud/username.text=parse["username"]
	json_file.close()
	if $PlayHud/username.text=="16" or $PlayHud/username.text=="-10":
		hack=1
	$ColorRect.show()
	$get_readyAudio.play()
	immune=0
	$Pause.hide()
	$get_ready.text="get ready!"
	$group_enemy.hide()
	$get_ready.show()
	$get_ready.position=Vector2(get_viewport_rect().size.x/2, get_viewport_rect().size.y*0.8/2)-$get_ready.size/2
	$get_ready/ReadyTimer.start()
	$group_enemy.connect("game_over",_on_ship_game_over)
	$ship.connect("game_over",_on_ship_game_over)

func on_damage():
	if immune==0:
		$ship_los.play()
		immune=1
		$ship.life-=1
		get_tree().call_group("ShipLife", "queue_free")
		$PlayHud/HBoxContainer.number=$ship.life
		$PlayHud/HBoxContainer.spawn()
		$PlayHud/Life.text=str($ship.life)
		$ship/InvincibleTimer.start()
		$ship/ship_Sprite.play("shield")
		
func _on_ship_not_immune():
	$ship/InvincibleTimer.stop()
	immune=0
	$ship/ship_Sprite.stop()
	$ship/ship_Sprite.animation="default"

func _process(_delta):
	if Input.is_action_pressed("shoot"):
		shoot()

func on_recharge():
	charger=1

func shoot():
	if charger==1:
		$ship_laser.play()
		var bullet := bullet_child.instantiate()
		add_child(bullet) 
		bullet.position=$ship.position+$ship/gun.position
		bullet.connect("recharge",on_recharge)
		bullet.connect("score", on_score)
		bullet.connect("ufo", ufo_sound)
		charger=hack

func ufo_sound():
	$ufo.play()

func _on_group_enemy_on_shoot(shooter_position):
	var enemy_bullet := enemy_bullet_child.instantiate()
	enemy_bullet.position=shooter_position
	add_child(enemy_bullet)
	enemy_bullet.connect("damage", on_damage)

func on_score(type):
	$PlayHud/points.text=str(int($PlayHud/points.text)+10*type)

func _on_group_enemy_victory():
	$victory.play()
	immune=0
	$UfoTimer.start()
	if get_tree()!=null:
		get_tree().call_group("shield_piece", "queue_free")
		get_tree().call_group("enemy_bullet", "queue_free")
		get_tree().call_group("bullet", "queue_free")
		get_tree().call_group("ShipLife", "queue_free")
	$group_enemy.start()
	$group_enemy.hide()
	$ship.life+=1
	$PlayHud/HBoxContainer.number=$ship.life
	$PlayHud/HBoxContainer.spawn()
	$PlayHud/Life.text=str($ship.life)
	$get_ready.text="Do it again!"
	$get_ready.show()
	$get_ready/AgainTimer.start()
	charger=0
	$group_enemy/ShootTimer.stop()
	$group_enemy/ShootTimer.wait_time-=0.1*$group_enemy.level
	$group_enemy.level+=1

func _on_again_timer_timeout():
	$group_enemy/ShootTimer.start()
	charger=1
	$get_ready/AgainTimer.stop()
	$group_enemy.show()
	$get_ready.hide()
	for x in range (4):
		var shield:= shields_child.instantiate()
		add_child(shield)
		shield.position=Vector2(get_viewport_rect().size.x*17.5/20-x*get_viewport_rect().size.x*5/20,get_viewport_rect().size.y*7/9)

func _on_ufo_timer_timeout():
	var ufo_child:= ufo.instantiate()
	var positions=[0,get_viewport_rect().size.x]
	add_child(ufo_child)
	ufo_child.position=Vector2(positions.pick_random(),get_viewport_rect().size.y*1.05/10)
	if ufo_child.position.x>get_viewport_rect().size.x/2:
		ufo_child.vel=-ufo_child.vel
	$UfoTimer.set_wait_time(randi_range(20, 40))
	$UfoTimer.start()

func _on_pause_button_pressed(): 
	get_tree().paused=true 
	$Pause.show()
	
func _on_ship_game_over():
	var json_file = FileAccess.open(data_file_path,FileAccess.READ)
	var json_file_text= json_file.get_as_text()
	var parse=JSON.parse_string(json_file_text)
	json_file.close()
	
	var new_json_file={
		"score"=int($PlayHud/points.text),
		"username"=$PlayHud/username.text
	}
	parse["leaderboard"].append(new_json_file)

	json_file=FileAccess.open(data_file_path,FileAccess.WRITE)
	json_file.store_string(JSON.stringify(parse," ", true))
	json_file.close()
	get_tree().change_scene_to_packed(game_over)
	
func _on_pause_resume():
	$Pause.hide()
	get_tree().paused=false

