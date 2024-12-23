extends Node
# I know... I hate this too.

var checkpoint_counter = 0
var current_level
var prev_scene

# On player die, if this is set to false, it will play the glitch effect
# Thank you @sorachu for suggesting the idea to disable glitch effect
var play_glitch_effect = true 


# Called when the node enters the scene tree for the first time.
func _ready():
	# print("test is: " + str(test))
	get_current_level()
	pass


func scene_changed(new_scene: PackedScene):
	# reset variable that is used to hold which checkpoints the player has touched
	# print(new_scene.resource_path)
	checkpoint_counter = 0

func change_to_new_scene(new_scene: PackedScene):
	get_tree().change_scene_to_packed(new_scene)

# This is some Java shit. 
func get_current_level():
	# print(get_node("/root").get_child(2))
	pass
	
func set_current_level():
	pass

func is_player(body):
	return body.get_class() == "CharacterBody2D" and body.name == "Player" and body.current_state != body.state.dying

func get_game_scene():
	var scene = get_node("/root").get_child(3)
	if scene.name.match("*cutscene*"):
		return null
	if scene.name.match("*scene*"):
		return scene 
	return null
