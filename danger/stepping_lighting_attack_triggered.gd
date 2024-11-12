extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		$stepping_lighting_attack.visible = true
		$stepping_lighting_attack.process_mode = Node.PROCESS_MODE_INHERIT
