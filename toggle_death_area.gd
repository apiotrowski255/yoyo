extends Area2D

@export var time_on : float = 1.0
@export var time_off : float = 2.0
var timer : Timer
var collisionshape : CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer
	timer.start(time_on)
	collisionshape = $CollisionShape2D
	pass # Replace with function body.



func _on_timer_timeout():
	if collisionshape.disabled == false:
		collisionshape.set_deferred("disabled", true)
		$ColorRect.visible = false
		timer.start(time_off)
		$AudioStreamPlayer2D.stop()
	elif collisionshape.disabled == true:
		collisionshape.set_deferred("disabled", false)
		timer.start(time_on)
		$ColorRect.visible = true
		$AudioStreamPlayer2D.play()



func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D" and body.name == "Player" and body.current_state != body.state.dying:
		# Again shit code
		# get_node("/root/scene_01")._on_death_body_entered(body)
		# print("kill player")
		get_node("/root/").get_child(2)._on_death_body_entered(body)
		
