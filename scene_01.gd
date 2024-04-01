extends Node2D

var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
	pass # Replace with function body.



func _on_death_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		print("do death animation")
		body.die()
		timer.start(1.5)
	pass # Replace with function body.

func _on_timer_timeout():
	get_tree().reload_current_scene()


func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		print("play break fall animation")
	pass # Replace with function body.




