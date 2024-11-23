extends Node2D

func _ready() -> void:
	$CanvasLayer.show()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "cutscene_01_02":
		# Need to save seperate stats from the same scene 01
		GlobalVariables.checkpoint_counter = 0
		get_tree().change_scene_to_file("res://levels/scene_01_02.tscn")
		
