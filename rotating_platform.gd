extends AnimatableBody2D

@export var speed = 1.0
# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	rotate(speed * delta)
