extends CharacterBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func take_hit():
	$health_bar.take_hit()
	$sprite.play("Take_hit")
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_blink_intensity, 1.0, 0.0, 0.5)

func set_shader_blink_intensity(newValue : float):
	$sprite.material.set_shader_parameter("blink_intensity", newValue)


func _on_sprite_animation_finished():
	if $health_bar.life == 0 and $sprite.animation == "Take_hit":
		$sprite.play("Death")
	if $sprite.animation == "Take_hit":
		$sprite.play("Idle")
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	if GlobalVariables.is_player(body):
		if body.current_state != body.state.shell:
			body.velocity.y = -250
			take_hit()
