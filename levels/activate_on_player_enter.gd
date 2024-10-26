extends Area2D

@export var scene_to_activate : Node2D = null
@export var process_mode_to_set = ProcessMode.PROCESS_MODE_INHERIT

func _on_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		scene_to_activate.process_mode = process_mode_to_set
		if process_mode_to_set == ProcessMode.PROCESS_MODE_DISABLED:
			scene_to_activate.queue_free()
		#self.process_mode = Node.PROCESS_MODE_DISABLED
		self.queue_free()
