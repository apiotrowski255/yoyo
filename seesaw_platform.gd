extends Node2D

@export var max_rotation_speed : float = 20
var current_rotation_speed : float
var current_rotation
@export var max_angle : int = 15
var platform : AnimatableBody2D
var player_on_platform : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	current_rotation_speed = 0.0
	platform = $RigidBody2D
	player_on_platform = false
	pass # Replace with function body.

func _physics_process(delta):
	
	current_rotation = platform.rotation_degrees
	platform.rotation_degrees = clamp(current_rotation + current_rotation_speed * delta, -max_angle, max_angle)


		


func _on_left_area_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		current_rotation_speed -= max_rotation_speed
		player_on_platform = true
	pass # Replace with function body.


func _on_right_area_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		current_rotation_speed += max_rotation_speed
		player_on_platform = true
	pass # Replace with function body.


func _on_left_area_body_exited(body):
	if body.get_class() == "CharacterBody2D":
		current_rotation_speed += max_rotation_speed
		player_on_platform = false
	pass # Replace with function body.


func _on_right_area_body_exited(body):
	if body.get_class() == "CharacterBody2D":
		current_rotation_speed -= max_rotation_speed
		player_on_platform = false
	pass # Replace with function body.
