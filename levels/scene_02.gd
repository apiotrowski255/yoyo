extends Node2D

var timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_death_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		# print("do death animation")
		body.die()
		timer.start(1.5)

func _on_timer_timeout():
	get_tree().reload_current_scene()
