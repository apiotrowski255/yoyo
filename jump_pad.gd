extends Area2D

@export var strength : Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.

var cpuparticles : CPUParticles2D

func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		body.jump_height = body.jump_height * strength.y 
		body.calculate_jump_parameters()
		# print(body.jump_height)
		cpuparticles = $CPUParticles2D


func _on_body_exited(body):
	if body.get_class() != "CharacterBody2D":
		return
	if body.get_class() == "CharacterBody2D" and body.velocity.y < -270.0:
		body.jump_particles.emitting = true
		body.timer.start(1.0)
		# print("play jump animation")
		# body.calculate_jump_parameters()
		cpuparticles.emitting = true
		jump_animation()
	# This is the case for the player walking off the jump pad
	if body.get_class() == "CharacterBody2D":
		body.jump_height = body.jump_height / strength.y # return Jump_Velocity back to normal value.
		body.calculate_jump_parameters()


func jump_animation() -> void:
	$AnimationPlayer.play("jump")
	pass
