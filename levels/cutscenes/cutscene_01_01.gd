extends Node2D

func _unhandled_key_input(event: InputEvent) -> void:
	if event.keycode == KEY_E:
		_on_animation_player_animation_finished("")
	else:
		$CanvasLayer/RichTextLabel.visible = true
		$Timer.start(3.0)


func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://levels/scene_01_01.tscn")
	GlobalMusicManager.fade_music(-10, 1.0)
	GlobalMusicManager.load_and_play_music("res://sounds/music/Rainoth - Border of Death [One Foot in the Grave EP].mp3")


func _on_timer_timeout() -> void:
	$CanvasLayer/RichTextLabel.visible = false
