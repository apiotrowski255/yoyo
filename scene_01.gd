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


func _on_area_2d_4_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		body.change_state(body.state.gliding)
		# body.current_state = body.state.gliding
		body.set_camera_bottom_margin(0.0)


func _on_area_2d_4_body_exited(body):
	if body.get_class() == "CharacterBody2D":
		body.change_state(body.state.normal)
		# body.current_state = body.state.normal
		body.set_camera_bottom_margin(0.6)
