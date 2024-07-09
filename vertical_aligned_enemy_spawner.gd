extends Node2D


var target
var spawn_location
var timer : Timer
@export var enemy_scene: PackedScene
@export var spawner_move_speed = 1.0

var move_speed = 32.0

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
	var target_x = target.global_position.x
	spawn_location.global_position.x = move_toward(spawn_location.global_position.x, target_x,  move_speed * delta)

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
	enemy.speed = 32
	self.add_child(enemy)
