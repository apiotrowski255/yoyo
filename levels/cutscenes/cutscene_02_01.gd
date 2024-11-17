extends Node2D



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "zozo_call":
		get_tree().change_scene_to_file("res://levels/scene_02_01.tscn")
		GlobalMusicManager.load_music("res://sounds/music/Rainoth Unmissed.mp3")
		GlobalMusicManager.play()
