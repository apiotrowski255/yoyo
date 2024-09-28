extends Node2D

func _ready() -> void:
	$CanvasLayer.show()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		# Need to save seperate stats from the same scene 01
		get_tree().change_scene_to_file("res://levels/scene_01.tscn")
		
