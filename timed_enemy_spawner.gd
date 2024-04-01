extends Node2D
@export var enemy_scene: PackedScene
var timer : Timer
@export var repeat_time : float = 2
@export var time_to_die : float = 10.0
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer
	timer.start(repeat_time)
	pass # Replace with function body.



func _on_timer_timeout():
	var enemy = enemy_scene.instantiate()
	enemy.time_to_die = time_to_die
	self.add_child(enemy)
	timer.start(repeat_time)
	pass # Replace with function body.
