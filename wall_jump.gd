extends Area2D
@export var state_to_transfer = 6
# 7 = wall_jump_right
# 6 = wall_jump_left

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		body.current_state = state_to_transfer
		body.gravity = body.gravity / 10
		body.velocity.x = 0
		body.velocity.y = 0


func _on_body_exited(body):
	if body.get_class() == "CharacterBody2D":
		body.current_state = body.state.in_air
		body.gravity = body.gravity * 10

