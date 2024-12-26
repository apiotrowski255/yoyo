extends Node2D


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")
	GlobalMusicManager.load_and_play_music("res://sounds/music/Rainoth - Patreon Saint of Psychopaths [One Foot in the Grave EP].mp3")
	GlobalMusicManager.fade_music(-10, 1.0)
	GlobalVariables.checkpoint_counter = 0
