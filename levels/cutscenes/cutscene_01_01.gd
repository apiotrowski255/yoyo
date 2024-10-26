extends Node2D

func _unhandled_key_input(event: InputEvent) -> void:
	if event.keycode == KEY_E:
		_on_animation_player_animation_finished("")
	else:
		$CanvasLayer/RichTextLabel.visible = true
		$Timer.start(3.0)


func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://levels/scene_01_01.tscn")
	GlobalMusicManager.load_music("res://sounds/music/Rainoth - Earth [ELEMENTS EP] (320).mp3")
	GlobalMusicManager.play()


func _on_timer_timeout() -> void:
	$CanvasLayer/RichTextLabel.visible = false
