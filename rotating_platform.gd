extends AnimatableBody2D

@export var rotation_speed = 1.0
# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	rotate(rotation_speed * delta)
