extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://levels/scene_01_01.tscn")
	GlobalMusicManager.load_music("res://sounds/music/Rainoth - Earth [ELEMENTS EP] (320).mp3")
	GlobalMusicManager.play()
