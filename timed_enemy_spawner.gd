class_name timed_enemy_spawner extends Node2D 
@export var enemy_scene: PackedScene
var timer : Timer
@export var repeat_time : float = 2
@export var time_to_die : float = 10.0
# Called when the node enters the scene tree for the first time.
@export var spawn_direction : Vector2 = Vector2.DOWN
@export var timed_enemy_speed : float = 32.0

@export var first_wait_timer : float = 0.0 # This variable will put a delay at the beginning of the spawn

var exiting = false

signal timed_enemy_spawned

@export var play_spawn_sfx : bool = true

func _ready():
	timer = $Timer
	if first_wait_timer == -1:
		pass
	elif first_wait_timer != 0:
		get_node("wait_timer").start(first_wait_timer)
	else:
		_on_timer_timeout()
		timer.start(repeat_time)
		timer.autostart = true
	$Sprite2D

func stop_spawning():
	timer.stop()

func start_spawning():
	timer.start()

func exit():
	stop_spawning()
	exiting = true

# spawn bullet
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
	if play_spawn_sfx == true:
		$AudioStreamPlayer2D.play()

func get_number_of_enemies():
	# minus one because we have a Timer child node. 
	return get_child_count() - 1

func is_empty():
	return get_number_of_enemies() == 0

func _on_child_exiting_tree(node):
	if get_number_of_enemies() == 1 and exiting == true:
		self.queue_free()




func _on_wait_timer_timeout():
	_on_timer_timeout()
	timer.start(repeat_time)
	timer.autostart = true

func hide_sprite():
	$Sprite2D.hide()
