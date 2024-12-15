extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/cutscenes/cutscene_01_01.tscn")
	


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/options_menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
