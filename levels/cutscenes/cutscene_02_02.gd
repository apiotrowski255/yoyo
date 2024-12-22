extends Node2D

func _ready() -> void:
	$CanvasLayer.show()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.keycode == KEY_E:
		_on_animation_player_animation_finished("cutscene_01_02")
	else:
		$CanvasLayer/RichTextLabel.visible = true
		$Timer.start(3.0)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "cutscene_01_03":
		GlobalVariables.checkpoint_counter = 0
		GlobalMusicManager.fade_music(-10, 1.0)
		get_tree().change_scene_to_file("res://levels/scene_01_03.tscn")
		
