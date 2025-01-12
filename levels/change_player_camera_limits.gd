extends Area2D


var old_bottom_limit
var old_top_limit
var old_left_limit
var old_right_limit

@export var new_bottom_limit = 10000000
@export var new_top_limit = -10000000
@export var new_left_limit = -10000000
@export var new_right_limit = 10000000

func _ready() -> void:
	self.connect("body_entered", _on_body_entered)
	self.connect("body_exited", _on_body_exited)


func _on_body_exited(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		body.get_node("Camera2D").limit_bottom = old_bottom_limit
		body.get_node("Camera2D").limit_top = old_top_limit
		body.get_node("Camera2D").limit_left = old_left_limit
		body.get_node("Camera2D").limit_right = old_right_limit


func _on_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		old_bottom_limit = body.get_node("Camera2D").limit_bottom
		old_top_limit = body.get_node("Camera2D").limit_top
		old_left_limit = body.get_node("Camera2D").limit_left
		old_right_limit = body.get_node("Camera2D").limit_right

		body.get_node("Camera2D").limit_bottom = new_bottom_limit
		body.get_node("Camera2D").limit_top = new_top_limit
		body.get_node("Camera2D").limit_left = new_left_limit
		body.get_node("Camera2D").limit_right = new_right_limit
