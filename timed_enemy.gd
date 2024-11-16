class_name timed_enemy extends Area2D

@export var time_to_die : float = 7.0
@export var speed : float = 32.0
@export var direction : Vector2 = Vector2.DOWN

var timer : Timer
var sprite_change_timer : Timer

var sprite : Sprite2D

var texture_1 = load("res://sprites/timed_enemy_1_1.png")
var texture_2 = load("res://sprites/timed_enemy_1_2.png")
var change_texture_time = 0.5

func _ready():
	timer = $Timer
	timer.start(time_to_die)
	sprite_change_timer = $sprite_change_timer
	sprite_change_timer.start(change_texture_time)
	sprite = $Sprite2D

func _physics_process(delta):
	position += direction * speed * delta

func _on_timer_timeout():
	# print("Do i want a disappear animation here?")
	self.queue_free()


func _on_body_entered(body):
	if GlobalVariables.is_player(body):
		var scene = get_node("/root/").get_child(2)
		if scene.name.match("*scene*"):
			get_node("/root/").get_child(2)._on_death_body_entered(body)
		else: 
			get_tree().reload_current_scene()

func _on_sprite_change_timer_timeout():
	if sprite.texture == texture_1:
		sprite.texture = load("res://sprites/timed_enemy_1_2.png")
	else:
		sprite.texture = load("res://sprites/timed_enemy_1_1.png")
	sprite_change_timer.start(change_texture_time)
