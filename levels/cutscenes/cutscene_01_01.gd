extends Node2D

func _unhandled_key_input(event: InputEvent) -> void:
	if event.keycode == KEY_E:
		_on_animation_player_animation_finished("")
	else:
		$CanvasLayer/RichTextLabel.visible = true
		$Timer.start(3.0)


func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://levels/scene_01_01.tscn")
	GlobalVariables.checkpoint_counter = 0
	GlobalVariables.current_level = 1
	GlobalVariables.current_sub_level = 1
	GlobalMusicManager.load_and_play_music("res://sounds/music/Untitled - Level 1.mp3")
	GlobalMusicManager.music_player.volume_db = -10


func _on_timer_timeout() -> void:
	$CanvasLayer/RichTextLabel.visible = false
