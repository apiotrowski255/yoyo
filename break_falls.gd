extends Area2D

@export var collision_width = 16
@export var collision_height = 16

var collision_box : CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	collision_box = $CollisionShape2D
	# Set default size of the collision rectangle
	collision_box.shape.size = Vector2(collision_width, collision_height)


func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D" and $CollisionShape2D.is_disabled() == false:
		print("play break fall animation")
		collision_box.set_deferred("disabled", true)
