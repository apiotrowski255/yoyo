extends RigidBody2D


var max_angle = 10

var ignore_player = false

@export var ignore : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# print(global_rotation_degrees)
	# print(ignore_player)
	if ignore == true:
		return
	
	if ignore_player == true:
		collision_mask = 0
		return
	if global_rotation_degrees > max_angle or global_rotation_degrees < -max_angle:
		collision_mask = 0
	else:
		collision_mask = 1
		ignore_player = false



func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		ignore_player = true



func _on_area_2d_body_exited(body):
	if body.get_class() == "CharacterBody2D":
		ignore_player = false
