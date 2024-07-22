extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#animated_sprite_2d.self_modulate = Color(85.0/255.0, 85.0/255.0, 85.0/255.0, 1.0)
	animated_sprite_2d.self_modulate = Color(0, 0, 0, 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate():
	animated_sprite_2d.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	animated_sprite_2d.play("default")
	$AudioStreamPlayer2D.play()
	collision_shape_2d.set_deferred("disabled", true)
	$CPUParticles2D3.emitting = true

func _on_area_2d_body_entered(body):
	# This might screw me up if a simple enemy encounters a flag
	if body.get_class() == "CharacterBody2D":
		activate()
