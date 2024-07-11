extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$music_player.play()
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("music_less"):
		$music_player.volume_db -= 5
	elif event.is_action_pressed("music_more"):
		$music_player.volume_db += 5
	elif event.is_action_pressed("music_pause"):
		$music_player.stream_paused = !$music_player.get_stream_paused()

