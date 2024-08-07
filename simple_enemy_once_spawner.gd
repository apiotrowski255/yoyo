extends Node2D

var simple_enemy_scene : PackedScene = preload("res://simple_enemy.tscn")
var simple_enemy
var timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	simple_enemy = simple_enemy_scene.instantiate()
	self.add_child(simple_enemy)
	timer = get_node("Timer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_child_exiting_tree(node):
	timer.start(3.0)
	$AnimationPlayer.play("charge")


func _on_timer_timeout():
	simple_enemy = simple_enemy_scene.instantiate()
	self.add_child(simple_enemy)
	timer.stop()
	$spawn_sfx.play()
