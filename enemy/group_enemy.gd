extends Area2D
const enemy_child: PackedScene = preload("res://enemy/enemy.tscn")
var matrix=[]
signal on_shoot
var vel=Vector2.ZERO
@export var level=1
@export var enemy_size:= Vector2(55,55)
@export var gap_size:=Vector2(5,5)
var _CollisionShape:= Vector2.ZERO
var lines_alive=[]
var columns_alive=[]
signal game_over
signal victory
var columns=11
var rows=5

func _ready():
	start()
	
func start():
	matrix=[]
	for x in range (columns):
		matrix.append([])
		for y in range (rows):
			var baby_enemy = enemy_child.instantiate()
			add_child(baby_enemy)
			baby_enemy.show()
			if y==0:
				baby_enemy.type=3
			elif y<3:
				baby_enemy.type=2
			else:
				baby_enemy.type=1
			baby_enemy.size=enemy_size
			baby_enemy.position=Vector2(x,y)*(baby_enemy.size+gap_size)
			var on_death:= Callable(on_CollisionShapeCalculator)
			baby_enemy.connect("tree_exited",on_death.bind(baby_enemy))
			baby_enemy.connect("game_over", on_game_over)
			matrix[x].append(baby_enemy)
	_CollisionShape=Vector2(11,5)*enemy_size+Vector2(10,4)*gap_size
	position=Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y*1.1/3)-_CollisionShape/2+enemy_size/2
	$group_enemy_CollisionShape.shape.extents=_CollisionShape/2
	$group_enemy_CollisionShape.position=Vector2(10*(gap_size.x+enemy_size.x)/2,$group_enemy_CollisionShape.shape.get_rect().size.y/2-enemy_size.y/2)
	$SliceTimer.wait_time=pow(11,1.5)/14
	vel=Vector2(get_viewport_rect().size.x/30,0)

func _on_slice_timer_timeout():
	if position.x+$group_enemy_CollisionShape.position.x+_CollisionShape.x/2+vel.x<get_viewport_rect().size.x and vel.x+$group_enemy_CollisionShape.position.x-_CollisionShape.x/2+position.x>0:
		position+=vel
	else:
		position.y+=abs(vel.x)
		vel=-vel

func _on_shoot_timer_timeout():
	var can_shoot=[]
	var shooter: Enemy
	var shooter_gun_position: Vector2
	for x in range (columns):
		for y in range (rows):
			var elem = matrix[x][rows-1-y]
			if elem != null:
				can_shoot.append(elem)
				break
	shooter=can_shoot.pick_random()
	shooter_gun_position=shooter.enemy_Gun.global_position
	on_shoot.emit(shooter_gun_position)

func on_CollisionShapeCalculator(baby_enemy):
	columns_alive=[]
	lines_alive=[]
	for x in range (columns):
		for y in range (rows):
			var elem = matrix[x][rows-1-y]
			if elem != null and elem!=baby_enemy:
				columns_alive.append(x)
				lines_alive.append(rows-1-y)
				break
	if columns_alive==[]:
		victory.emit()
	else:
		var _max_l: float=lines_alive.max()
		var _max_c: float=columns_alive.max()
		var _min_c: float=columns_alive.min()
		$SliceTimer.wait_time=pow((_max_c-_min_c+1),1.5)/14
		_CollisionShape=Vector2(_max_c-_min_c+1,_max_l+1)*enemy_size+Vector2(_max_c-_min_c,_max_l)*gap_size
		$group_enemy_CollisionShape.shape.extents=_CollisionShape/2
		$group_enemy_CollisionShape.position=Vector2(_max_c*(gap_size.x+enemy_size.x)/2+_min_c*(gap_size.x+enemy_size.x)/2,$group_enemy_CollisionShape.shape.get_rect().size.y/2-enemy_size.y/2)

func on_game_over():
	game_over.emit()
