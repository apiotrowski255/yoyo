extends Node2D
@export var enemy_scene: PackedScene
var timer : Timer
@export var repeat_time : float = 2
@export var time_to_die : float = 10.0
# Called when the node enters the scene tree for the first time.
@export var spawn_direction : Vector2 = Vector2.DOWN
@export var timed_enemy_speed : float = 32.0

var exiting = false

signal timed_enemy_spawned

func _ready():
	timer = $Timer
	timer.start(repeat_time)

func stop_spawning():
	timer.stop()

func start_spawning():
	timer.start()

func exit():
	stop_spawning()
	exiting = true

func _on_timer_timeout():
	if exiting == true:
		return
	var enemy = enemy_scene.instantiate()
	enemy.time_to_die = time_to_die
	enemy.direction = spawn_direction
	enemy.speed = timed_enemy_speed
	# enemy.process_mode = Node.PROCESS_MODE_ALWAYS
	# get_tree().root.add_child(enemy)
	self.add_child(enemy)
	timer.start(repeat_time)
	emit_signal("timed_enemy_spawned")

func get_number_of_enemies():
	# minus one because we have a Timer child node. 
	return get_child_count() - 1

func is_empty():
	return get_number_of_enemies() == 0

func _on_child_exiting_tree(node):
	if get_number_of_enemies() == 1 and exiting == true:
		self.queue_free()


