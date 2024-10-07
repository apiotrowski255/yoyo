extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		body.change_state(body.state.gliding)
		# body.current_state = body.state.gliding

func _on_body_exited(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		body.change_state(body.state.normal)
		# body.current_state = body.state.normal
