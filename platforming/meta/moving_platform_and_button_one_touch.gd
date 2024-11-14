extends Node2D

@export var end_position : Vector2 = Vector2(128, 8)
@export var platform_speed : float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatableBody2D.end_position = end_position 
	$AnimatableBody2D.speed = platform_speed
