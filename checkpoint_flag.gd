extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D

# Flags are used as a checkpoint. 

# Called when the node enters the scene tree for the first time.
func _ready():
	#animated_sprite_2d.self_modulate = Color(85.0/255.0, 85.0/255.0, 85.0/255.0, 1.0)
	animated_sprite_2d.self_modulate = Color(0, 0, 0, 1.0)

func activate():
	animated_sprite_2d.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	animated_sprite_2d.play("default")
	$AudioStreamPlayer2D.play()
	collision_shape_2d.set_deferred("disabled", true)
	$CPUParticles2D3.emitting = true
	GlobalVariables.checkpoint_counter += 1
	GlobalVariables.save_game_state()

func _on_area_2d_body_entered(body):
	# This might screw me up if a simple enemy encounters a flag
	if GlobalVariables.is_player(body):
		activate()

func disable_collision():
	collision_shape_2d.set_deferred("disabled", true)

func already_activate():
	collision_shape_2d.set_deferred("disabled", true)
	animated_sprite_2d.self_modulate = Color(1.0, 1.0, 1.0, 1.0)
	animated_sprite_2d.play("default")

func get_player_spawn_position():
	return $Area2D/CollisionShape2D.global_position
