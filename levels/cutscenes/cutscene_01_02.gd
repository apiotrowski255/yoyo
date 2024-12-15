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
		# Need to save seperate stats from the same scene 01
		GlobalVariables.checkpoint_counter = 0
		GlobalMusicManager.resume_music()
		get_tree().change_scene_to_file("res://levels/scene_01_02.tscn")
		
