extends Node2D

var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	# print("test variable is: " + str(GlobalVariables.test))
	'''
	if GlobalVariables.test == 0:
		$Player.position = Vector2(-656, -96)
	elif GlobalVariables.test == 1:
		$Player.global_position = Vector2(2120, 228)
		$checkpoint_areas/CollisionShape2D.set_deferred("disabled", true)
	elif GlobalVariables.test == 2:
		$Player.global_position = Vector2(2392, 44)
		# Other thing to consider is to not load in the birds (because they should be been scared away)
		# Also need to use set_deferred instead. 
		$checkpoint_areas/CollisionShape2D.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D2.set_deferred("disabled", true)
	elif GlobalVariables.test == 3:
		$Player.global_position = Vector2(3768, 128)
		$checkpoint_areas/CollisionShape2D.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D2.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D3.set_deferred("disabled", true)
	elif GlobalVariables.test == 4:
		$Player.global_position = Vector2(4744, 112)
		$checkpoint_areas/CollisionShape2D.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D2.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D3.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D4.set_deferred("disabled", true)
	elif GlobalVariables.test == 5:
		$Player.global_position = Vector2(5720, -100)
		$checkpoint_areas/CollisionShape2D.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D2.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D3.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D4.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D5.set_deferred("disabled", true)
	elif GlobalVariables.test == 6:
		$Player.global_position = Vector2(6712, -420)
		$checkpoint_areas/CollisionShape2D.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D2.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D3.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D4.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D5.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D6.set_deferred("disabled", true)
	elif GlobalVariables.test == 7:
		$Player.position = Vector2(6744, -648)
		$checkpoint_areas/CollisionShape2D.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D2.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D3.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D4.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D5.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D6.set_deferred("disabled", true)
		$checkpoint_areas/CollisionShape2D7.set_deferred("disabled", true)
	'''
	$Player.start_camera_smoothing_timer()
	timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)


func _on_death_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		# print("do death animation")
		body.die()
		timer.start(1.5)

func _on_timer_timeout():
	get_tree().reload_current_scene()


func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		# print("play break fall animation")
		pass
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


func _on_checkpoint_areas_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		GlobalVariables.test += 1
	# This is terrible code - Need to check which collisionshape is colliding with the player.
	# Or find another way of implementing this. 
		if $checkpoint_areas/CollisionShape2D.disabled == false:
			$checkpoint_areas/CollisionShape2D.set_deferred("disabled", true)
		elif $checkpoint_areas/CollisionShape2D2.disabled == false:
			$checkpoint_areas/CollisionShape2D2.set_deferred("disabled", true)
		elif $checkpoint_areas/CollisionShape2D3.disabled == false:
			$checkpoint_areas/CollisionShape2D3.set_deferred("disabled", true)
		elif $checkpoint_areas/CollisionShape2D4.disabled == false:
			$checkpoint_areas/CollisionShape2D4.set_deferred("disabled", true)
		elif $checkpoint_areas/CollisionShape2D5.disabled == false:
			$checkpoint_areas/CollisionShape2D5.set_deferred("disabled", true)
		elif $checkpoint_areas/CollisionShape2D6.disabled == false:
			$checkpoint_areas/CollisionShape2D6.set_deferred("disabled", true)
		elif $checkpoint_areas/CollisionShape2D7.disabled == false:
			$checkpoint_areas/CollisionShape2D7.set_deferred("disabled", true)


func _on_path_2d_kill_player(body):
	_on_death_body_entered(body)

