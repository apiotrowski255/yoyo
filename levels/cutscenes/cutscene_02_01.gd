extends Node2D

func _ready() -> void:
	$CanvasLayer.show()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.keycode == KEY_E:
		_on_animation_player_animation_finished("zozo_call")
	else:
		$CanvasLayer/RichTextLabel.visible = true
		$Timer.start(3.0)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "zozo_call":
		GlobalVariables.checkpoint_counter = 0
		GlobalVariables.current_level = 2
		GlobalVariables.current_sub_level = 1
		get_tree().change_scene_to_file("res://levels/scene_02_01.tscn")
		GlobalMusicManager.load_music("res://sounds/music/Rainoth Unmissed.mp3")
		GlobalMusicManager.fade_music(-10, 1.0)
		GlobalMusicManager.play()


func _on_timer_timeout() -> void:
	$CanvasLayer/RichTextLabel.visible = false
