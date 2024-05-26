extends Area2D

@export var target_velocity : Vector2 = Vector2(300, -400)
@export var do_a_flip : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		body.velocity = target_velocity
		if do_a_flip:
			body.do_a_flip()
