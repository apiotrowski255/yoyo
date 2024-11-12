extends Node2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		$lighting_attack_01.process_mode = Node.PROCESS_MODE_INHERIT
		$lighting_attack_01.visible = true


func _on_child_exiting_tree(node: Node) -> void:
	self.queue_free()
