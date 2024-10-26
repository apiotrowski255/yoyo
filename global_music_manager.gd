extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Default to Earth song
	$music_player.stream = load("res://sounds/music/Rainoth - Earth [ELEMENTS EP] (320).mp3")
	
	
	if get_node("/root/scene_01") != null:
		$music_player.play()
	elif get_node("/root/scene_02") != null:
		$music_player.stream = load("res://sounds/music/Rainoth Unmissed.mp3")
		$music_player.play()
	elif get_node("/root/scene_03") != null:
		$music_player.stream = load("res://sounds/music/City Chase Club Mix.mp3")
		$music_player.play()
	elif get_node("/root/main_menu") != null:
		# We need main menu music
		pass

func stop():
	$music_player.stop()

func load_music(string : String):
	$music_player.stream = load(string)

func play():
	$music_player.play()

func _input(event):
	if event.is_action_pressed("music_less"):
		decrease_music_volume()
	elif event.is_action_pressed("music_more"):
		increase_music_volume()
	elif event.is_action_pressed("music_pause"):
		pause_music()

func increase_music_volume():
	if $music_player.volume_db >= 0:
		return
	$music_player.volume_db += 5
	
func decrease_music_volume():
	if $music_player.volume_db <= -40:
		return
	$music_player.volume_db -= 5

func pause_music():
	$music_player.stream_paused = !$music_player.get_stream_paused()



# Rainoth Earth - Set import to loop
func scene_changed(new_scene: PackedScene):
	# load the new music of the new scene

	if new_scene.resource_path == "res://levels/scene_02.tscn":
		$music_player.stop()
		$music_player.stream = load("res://sounds/music/Rainoth Unmissed.mp3")
		$music_player.play()
	pass
