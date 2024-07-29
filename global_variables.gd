extends Node
# I know... I hate this too.

var test = 0
var current_level

# Called when the node enters the scene tree for the first time.
func _ready():
	# print("test is: " + str(test))
	get_current_level()
	pass


func scene_changed(new_scene: PackedScene):
	# reset variable that is used to hold which checkpoints the player has touched
	print(new_scene.resource_path)
	test = 0

# This is some Java shit. 
func get_current_level():
	# print(get_node("/root").get_child(2))
	pass
	
func set_current_level():
	pass
