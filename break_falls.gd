extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D" and $CollisionShape2D.is_disabled() == false:
		print("play break fall animation")
		$CollisionShape2D.set_disabled(true)
