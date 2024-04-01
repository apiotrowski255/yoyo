extends Area2D


func _on_body_entered(body):
	if body.get_class() != "CharacterBody2D":
		return
	body.JUMP_VELOCITY = -100.0
	body.current_state = body.state.climb


func _on_body_exited(body):
	if body.get_class() != "CharacterBody2D":
		return
	body.JUMP_VELOCITY = -300.0
	body.current_state = body.state.normal
