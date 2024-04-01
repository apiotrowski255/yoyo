extends Node2D

var timer
var collisionshape
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer
	collisionshape = $StaticBody2D/CollisionShape2D
	pass # Replace with function body.



func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		timer.start(1.5)
	pass # Replace with function body.


func _on_timer_timeout():
	if collisionshape.disabled == false:
		collisionshape.set_deferred("disabled", true)
	elif collisionshape.disabled == true:
		collisionshape.set_deferred("disabled", false)
		timer.stop()
