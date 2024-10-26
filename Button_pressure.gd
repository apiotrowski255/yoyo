extends Area2D

@export var door: CollisionShape2D
# Called when the node enters the scene tree for the first time.
var number_of_objects
var sprite2d : Sprite2D

func _ready():
	number_of_objects = 0
	sprite2d = $Sprite2D

func _on_body_entered(body):
	if GlobalVariables.is_player(body) or body.get_class() == "RigidBody2D":
		number_of_objects += 1
		# print("TODO: Opening door - Animate button")
		if door != null:
			door.set_deferred("disabled", true)
			door.get_child(0).visible = false
		sprite2d.texture = load("res://button_pressed.png")
		$sfx/button_on.play()
	# print(number_of_objects)
		


func _on_body_exited(body):
	if GlobalVariables.is_player(body) or body.get_class() == "RigidBody2D":
		number_of_objects -= 1
		if number_of_objects == 0:
			# print("TODO: closing door - Animate button")
			if door != null:
				door.set_deferred("disabled", false)
				door.get_child(0).visible = true
			sprite2d.texture = load("res://button_open.png")
			$sfx/button_off.play()
