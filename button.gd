extends Area2D

@export var door: CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		print("Opening door")
		print("Animated button")
		door.set_deferred("disabled", true)
