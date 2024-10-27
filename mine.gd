extends Area2D

var timer : Timer
var sprite : Sprite2D

var texture_1 = load("res://sprites/timed_enemy_1_1.png")
var texture_2 = load("res://sprites/timed_enemy_1_2.png")

var change_texture_time : float

# Called when the node enters the scene tree for the first time.
func _ready():
	change_texture_time = 0.5
	timer = $Timer
	timer.start(change_texture_time)
	sprite = $Sprite2D


func _on_timer_timeout():
	if sprite.texture == texture_1:
		sprite.texture = load("res://sprites/timed_enemy_1_2.png")
	else:
		sprite.texture = load("res://sprites/timed_enemy_1_1.png")
	timer.start(change_texture_time)


func _on_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		var scene = get_node("/root/").get_child(2)
		if scene.name.match("*scene*"):
			get_node("/root/").get_child(2)._on_death_body_entered(body)
		else: 
			get_tree().reload_current_scene()
