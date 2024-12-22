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
	if GlobalVariables.is_player(body):
		var scene = get_node("/root/").get_child(3)
		if scene.name.match("*scene*"):
			get_node("/root/").get_child(3)._on_death_body_entered(body)
		else: 
			get_tree().reload_current_scene()
		
