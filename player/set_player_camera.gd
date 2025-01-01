extends Area2D

# Will deattach the camera from the player and will set the camera to a defined position
@export var new_position : Vector2 = Vector2(0,0)
var camera

func _on_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		var global_position = body.get_node("Camera2D").global_position
		camera = body.get_node("Camera2D")
		
		camera.global_position = new_position
		camera.reparent(self)


func _on_body_exited(body: Node2D) -> void:
	return
	if GlobalVariables.is_player(body):
		camera.reparent(body)
