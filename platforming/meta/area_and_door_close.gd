extends Node2D

# When player enter the area, the door will close behind them.
@onready var collision_shape_2d = $StaticBody2D/CollisionShape2D
@onready var audio_stream_player_2d = $StaticBody2D/AudioStreamPlayer2D
@onready var area_2d = $Area2D


func _on_area_2d_body_entered(body):
	if collision_shape_2d.disabled == true and GlobalVariables.is_player(body):
		collision_shape_2d.set_deferred("disabled", false)
		audio_stream_player_2d.play()
		area_2d.set_deferred("monitoring", false)
