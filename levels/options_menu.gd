extends Control


func _ready() -> void:
	if GlobalVariables.play_glitch_effect == false:
		$Label2.text = "Disabled"
		$CheckButton.button_pressed = false
	else:
		$Label2.text = "Enabled"
		$CheckButton.button_pressed = true
	var mouse_position = get_viewport().get_mouse_position() / 10
	$mountain_dusk_parallax.scroll_offset = mouse_position

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		$Label2.text = "Disabled"
	else:
		$Label2.text = "Enabled"
	GlobalVariables.play_glitch_effect = toggled_on

func _process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position() / 10
	$mountain_dusk_parallax.scroll_offset = mouse_position
