extends Node2D


var target
var spawn_location
var timer : Timer
@export var enemy_scene: PackedScene
@export var spawner_move_speed = 64.0
@export var projectile_speed = 256.0

# Called when the node enters the scene tree for the first time.
func _ready():
	target = null
	spawn_location = get_node("Sprite2D")
	timer = get_node("Timer")
	timer.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target == null:
		return
	var p1 : Vector2 = target.global_position
	var p2 : Vector2 = spawn_location.global_position
	var h : float = p1.distance_to(p2)
	var angle : float = p2.angle_to_point(p1)
	var x_modifier : float = h * cos(angle)
	
	print("---")
	print(self.rotation)
	print(angle)
	print("---")
	
	
	var target_x = target.position.x
	
	
	
	
	# print(target_x)
	# print(spawn_location.position.x)
	# spawn_location.global_position.x = move_toward(spawn_location.spawn_location.x, target_x,  spawner_move_speed * delta)

func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		target = body
		timer.start()


func _on_area_2d_body_exited(body):
	if body.get_class() == "CharacterBody2D":
		target = null
		timer.stop()


func _on_timer_timeout():
	# print("spawn timed enemy")
	var enemy = enemy_scene.instantiate()
	enemy.position = spawn_location.position
	enemy.time_to_die = 6.0
	enemy.direction = Vector2.DOWN
	enemy.speed = projectile_speed
	self.add_child(enemy)
	$Sprite2D/AudioStreamPlayer2D.play()
