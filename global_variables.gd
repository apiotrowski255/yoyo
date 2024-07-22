extends Node
# I know... I hate this too.

var test = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# print("test is: " + str(test))
	pass


func scene_changed(new_scene: PackedScene):
	# reset variable that is used to hold which checkpoints the player has touched
	print(new_scene.resource_path)
	test = 0
