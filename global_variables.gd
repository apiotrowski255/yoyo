extends Node
# I know... I hate this too.

var checkpoint_counter = 0
var current_level = 1
var current_sub_level = 1

# On player die, if this is set to false, it will play the glitch effect
# Thank you @sorachu for suggesting the idea to disable glitch effect
var play_glitch_effect = true 

# attempting to make a load and save function
var save_path = "user://variable.save"

# Called when the node enters the scene tree for the first time.
func _ready():
	load_previous_game_state()
	print("--- stats ---")
	print(checkpoint_counter)
	print(current_level)
	print(current_sub_level)
	print("------")

func _exit_tree() -> void:
	print(checkpoint_counter)
	print(current_level)
	print(current_sub_level)
	save_game_state()

func scene_changed(new_scene: PackedScene):
	# reset variable that is used to hold which checkpoints the player has touched
	# print(new_scene.resource_path)
	checkpoint_counter = 0

func change_to_new_scene(new_scene: PackedScene):
	get_tree().change_scene_to_packed(new_scene)

func is_player(body):
	return body.get_class() == "CharacterBody2D" and body.name == "Player" and body.current_state != body.state.dying

func get_game_scene():
	var scene = get_node("/root").get_child(3)
	if scene == null:
		return null
	if scene.name.match("*cutscene*"):
		return null
	if scene.name.match("*scene*"):
		return scene 
	return null

func get_current_game_level():
	if get_game_scene() == null:
		return null
	else:
		var name = get_game_scene().name
		name = name.substr(6)
		return name

func load_level_from_save():
	var level = "scene_0" + str(current_level) + "_0" + str(current_sub_level)
	get_tree().change_scene_to_file("res://levels/" + level + ".tscn")
	if current_level == 1:
		GlobalMusicManager.load_and_play_music("res://sounds/music/Untitled - Level 1.mp3")
	elif current_level == 2:
		GlobalMusicManager.load_and_play_music("res://sounds/music/Rainoth Unmissed.mp3")

func save_game_state():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(checkpoint_counter)
	file.store_var(current_level)
	file.store_var(current_sub_level)

func load_previous_game_state():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		checkpoint_counter = file.get_var(checkpoint_counter)
		current_level = file.get_var(current_level)
		current_sub_level = file.get_var(current_sub_level)
	else:
		checkpoint_counter = null
		current_level = null
		current_sub_level = null
