extends Area2D


@export var new_drag_bottom_margin : float = 0.0
@export var new_drag_top_margin : float = 0.0
@export var new_drag_left_margin : float = 0.0
@export var new_drag_right_margin : float = 0.0
@export var offset : Vector2 = Vector2(0,0)

var old_drag_bottom_margin : float
var old_drag_top_margin : float
var old_drag_left_margin : float
var old_drag_right_margin : float
var old_offset : Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("body_entered", _on_body_entered)
	self.connect("body_exited", _on_body_exited)


func _on_body_exited(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		body.get_node("Camera2D").drag_bottom_margin = 0.6


func _on_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body): 
		body.get_node("Camera2D").drag_bottom_margin = 0
