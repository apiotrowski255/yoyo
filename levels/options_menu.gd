extends Control


func _ready() -> void:
	if GlobalVariables.play_glitch_effect == false:
		$Label2.text = "Disabled"
		$CheckButton.button_pressed = false
	else:
		$Label2.text = "Enabled"
		$CheckButton.button_pressed = true

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		$Label2.text = "Disabled"
	else:
		$Label2.text = "Enabled"
	GlobalVariables.play_glitch_effect = toggled_on

	
