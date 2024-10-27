extends Area2D

enum modes {increase_volume, decrease_volume}

@export var current_mode = modes.increase_volume

func _on_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		if current_mode == modes.increase_volume:
			GlobalMusicManager.increase_music_volume()
		elif current_mode == modes.decrease_volume:
			GlobalMusicManager.decrease_music_volume()
		$Sprite2D.texture = load("res://button_pressed.png")
		$sfx/button_on.play()


func _on_body_exited(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		$Sprite2D.texture = load("res://button_open.png")
		$sfx/button_off.play()
