extends Area2D

@export var strength : Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.


func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		body.JUMP_VELOCITY = strength.y 


func _on_body_exited(body):
	if body.get_class() != "CharacterBody2D":
		return
	if body.get_class() == "CharacterBody2D" and body.velocity.y < -350.0:
		print("play jump animation")
	if body.get_class() == "CharacterBody2D":
		body.JUMP_VELOCITY = -300.0 # return Jump_Velocity back to normal value.
