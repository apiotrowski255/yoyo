extends Node2D

@export var time_to_break = 1.5

var timer
var collisionshape
var sprite
var animationPlayer
# Called when the node enters the scene tree for the first time.

func _ready():
	timer = $Timer
	collisionshape = $StaticBody2D/CollisionShape2D
	sprite = $RotatingSide
	animationPlayer = $AnimationPlayer



func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		# print("play breaking animation - or shake the sprite")
		if collisionshape.disabled == false and timer.is_stopped() == true:
			timer.start(time_to_break)
			animationPlayer.play("sprite_shake")
			body.play_stomp_sfx()


func _on_timer_timeout():
	if collisionshape.disabled == false:
		collisionshape.set_deferred("disabled", true)
		sprite.set_deferred("visible", false)
		var death_particles_scene = preload("res://particle_effects/breaking_platform_particle_effect.tscn")
		var death_particles = death_particles_scene.instantiate()
		death_particles.position = Vector2(16, 8)
		death_particles.emitting = true
		self.add_child(death_particles)
		
	elif collisionshape.disabled == true:
		collisionshape.set_deferred("disabled", false)
		sprite.set_deferred("visible", true)
		timer.stop()
