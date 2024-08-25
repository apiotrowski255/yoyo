extends Area2D


enum state {wall_jump_left, wall_jump_right}
@export var state_to_transfer = state.wall_jump_left
# 7 = wall_jump_right
# 6 = wall_jump_left

func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		body.current_state = state_to_transfer + 6
		body.gravity_modifier = body.gravity_modifier / 10
		body.velocity.x = 0
		body.velocity.y = 0


func _on_body_exited(body):
	if body.get_class() == "CharacterBody2D":
		body.current_state = body.state.in_air
		body.gravity_modifier = body.gravity_modifier * 10
