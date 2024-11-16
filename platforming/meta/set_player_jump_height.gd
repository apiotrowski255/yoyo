extends Node2D

@export var new_height: float = 64
var old_height

func _on_area_2d_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		old_height = body.jump_height
		body.jump_height = new_height
		body.recalculate_jump_parameters()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		body.jump_height = old_height
		body.recalculate_jump_parameters()
