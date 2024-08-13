extends Node2D

@onready var death_hit_box = $death_hit_box
var target
@onready var color_rect = $death_hit_box/ColorRect
@onready var audio_stream_player_2d = $death_hit_box/AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	target = null
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target == null:
		return
	death_hit_box.global_position.x = move_toward(death_hit_box.global_position.x, target.global_position.x, 1)


func _on_trigger_body_entered(body):
	if GlobalVariables.is_player(body):
		target = body
	pass # Replace with function body.


func _on_trigger_body_exited(body):
	if GlobalVariables.is_player(body):
		target = null
		# Disable death_hit_box

		# hide sprite
		color_rect.visible = false
		# Stop playing laser sound effect
		audio_stream_player_2d.stop()
	pass # Replace with function body.
