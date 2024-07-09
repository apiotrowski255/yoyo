extends Area2D

@export var door: CollisionShape2D
# Called when the node enters the scene tree for the first time.
var number_of_objects
var sprite2d : Sprite2D
func _ready():
	number_of_objects = 0
	sprite2d = $Sprite2D

func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D" or body.get_class() == "RigidBody2D":
		number_of_objects += 1
		# print("TODO: Opening door - Animate button")
		if door != null:
			door.set_deferred("disabled", true)
		sprite2d.texture = load("res://button_pressed.png")
	# print(number_of_objects)


func _on_body_exited(body):
	if body.get_class() == "CharacterBody2D" or body.get_class() == "RigidBody2D":
		number_of_objects -= 1
		if number_of_objects == 0:
			# print("TODO: closing door - Animate button")
			if door != null:
				door.set_deferred("disabled", false)
			sprite2d.texture = load("res://button_open.png")

