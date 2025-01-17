extends Node2D


var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer
var is_fading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	music_player = get_node("music_player")
	# Default to Earth song
	# music_player.stream = load("res://sounds/music/Rainoth - Earth [ELEMENTS EP] (320).mp3")
	
	if get_node("/root/main_menu") != null:
		music_player.stream = load("res://sounds/music/Untitled - Main Menu.mp3")
		music_player.play()
		music_player.volume_db = -20
		fade_music(-10, 1.5)

	if get_node("/root/scene_02") != null:
		music_player.stream = load("res://sounds/music/Rainoth Unmissed.mp3")
		music_player.play()
	elif get_node("/root/scene_03") != null:
		music_player.stream = load("res://sounds/music/City Chase Club Mix.mp3")
		music_player.play()


func stop():
	music_player.stop()

func load_music(music : String):
	music_player.stream = load(music)

func play():
	music_player.play()

func load_and_play_music(music) -> void:
	music_player.stream = load(music)
	music_player.play()

func _input(event):
	if event.is_action_pressed("music_less") and get_node("/root/OptionsMenuInGame").get_node("CanvasLayer").visible == false and GlobalVariables.get_game_scene() != null and GlobalVariables.get_game_scene().get_node("Player").current_state != player.state.cutscene:
		decrease_music_volume()
	elif event.is_action_pressed("music_more") and get_node("/root/OptionsMenuInGame").get_node("CanvasLayer").visible == false and GlobalVariables.get_game_scene() != null and GlobalVariables.get_game_scene().get_node("Player").current_state != player.state.cutscene:
		increase_music_volume()
	elif event.is_action_pressed("music_pause") and get_node("/root/OptionsMenuInGame").get_node("CanvasLayer").visible == false and GlobalVariables.get_game_scene() != null and GlobalVariables.get_game_scene().get_node("Player").current_state != player.state.cutscene:
		pause_music()

func increase_music_volume():
	if music_player.volume_db >= 0:
		return
	if is_fading == true:
		return
	if GlobalVariables.get_game_scene() == null:
		return
	music_player.volume_db += 5
	
func decrease_music_volume():
	if music_player.volume_db <= -40:
		return
	if is_fading == true:
		return
	if GlobalVariables.get_game_scene() == null:
		return
	music_player.volume_db -= 5

func fade_music(new_volume: float, time:float):
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", new_volume, time)
	tween.play()
	is_fading = true
	tween.connect("finished", _tween_finished)
	
func _tween_finished():
	is_fading = false

func pause_music():
	music_player.stream_paused = !music_player.get_stream_paused()

func pause_music_2():
	music_player.stream_paused = true
	
func resume_music():
	music_player.stream_paused = false

func is_music_paused():
	return music_player.get_stream_paused()

# Rainoth Earth - Set import to loop
func scene_changed(new_scene: PackedScene):
	# load the new music of the new scene

	if new_scene.resource_path == "res://levels/scene_02.tscn":
		music_player.stop()
		music_player.stream = load("res://sounds/music/Rainoth Unmissed.mp3")
		music_player.play()
	pass
	
	
func play_menu_button_pressed_sfx():
	$sfx_player.play()
	

func play_mouse_over_button_sfx():
	$menu_over_button_sfx.play()
