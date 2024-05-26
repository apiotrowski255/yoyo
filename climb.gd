extends Area2D

var strength : float = 10.0
var strength2 : float = 6.0

func _on_body_entered(body):
	if body.get_class() != "CharacterBody2D":
		return
	body.jump_height = body.jump_height / strength
	body.jump_time_to_peak = body.jump_time_to_peak / strength2
	body.jump_time_to_descent = body.jump_time_to_descent / strength2
	body.calculate_jump_parameters()
	body.current_state = body.state.climb


func _on_body_exited(body):
	if body.get_class() != "CharacterBody2D":
		return
	body.jump_height = body.jump_height * strength
	body.jump_time_to_peak = body.jump_time_to_peak * strength2
	body.jump_time_to_descent = body.jump_time_to_descent * strength2
	body.calculate_jump_parameters()
	body.current_state = body.state.normal
