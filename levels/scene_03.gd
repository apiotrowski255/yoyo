extends Node2D

var timer : Timer

func _ready() -> void:
	timer = get_node("Timer")

func _on_death_body_entered(body):
	if GlobalVariables.is_player(body):
		# print("do death animation")
		body.die()
		timer.start(1.5)

func _on_timer_timeout():
	get_tree().reload_current_scene()
