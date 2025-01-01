extends Node2D


func _unhandled_key_input(event: InputEvent) -> void:
	if event.keycode == KEY_E:
		_on_animation_player_animation_finished("cutscene_01_02")
	else:
		$CanvasLayer/RichTextLabel.visible = true
		$Timer.start(3.0)

func _ready() -> void:
	$CanvasLayer.show()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "cutscene_01_02":
		GlobalVariables.checkpoint_counter = 0
		GlobalVariables.current_level = 1
		GlobalVariables.current_sub_level = 2
		get_tree().change_scene_to_file("res://levels/scene_01_02.tscn")
		GlobalMusicManager.fade_music(-10, 1)
		

func _on_timer_timeout() -> void:
	$CanvasLayer/RichTextLabel.visible = false
