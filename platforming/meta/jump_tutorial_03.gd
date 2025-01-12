extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		body.get_node("Camera2D").drag_right_margin = 0
		body.get_node("Camera2D").position = Vector2(64, 0)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		body.get_node("Camera2D").drag_right_margin = 0.2
		body.get_node("Camera2D").position = Vector2(0,0)
