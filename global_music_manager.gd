extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Default to Earth song
	$music_player.stream = load("res://sounds/music/Rainoth - Earth [ELEMENTS EP] (320).mp3")
	
	if get_node("/root/scene_01") != null:
		$music_player.play()
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("music_less"):
		$music_player.volume_db -= 5
	elif event.is_action_pressed("music_more"):
		$music_player.volume_db += 5
	elif event.is_action_pressed("music_pause"):
		$music_player.stream_paused = !$music_player.get_stream_paused()

# Rainoth Earth - Set import to loop


func scene_changed(new_scene: PackedScene):
	# load the new music of the new scene

	if new_scene.resource_path == "res://levels/scene_02.tscn":
		$music_player.stop()
		$music_player.stream = load("res://sounds/music/City Chase Club Mix.mp3")
		$music_player.play()
	pass
