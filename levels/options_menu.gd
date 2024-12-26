extends Control


func _ready() -> void:
	set_options()
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
	GlobalMusicManager.play_menu_button_pressed_sfx()


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		$Label2.text = "Disabled"
	else:
		$Label2.text = "Enabled"
	GlobalVariables.play_glitch_effect = toggled_on

func _process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position() / 10
	$mountain_dusk_parallax.scroll_offset = mouse_position


func _on_button_mouse_entered() -> void:
	GlobalMusicManager.play_mouse_over_button_sfx()


func set_options():
	# for example if glitch effect is already turned off, then it should be turned off in the options menu
	if GlobalVariables.play_glitch_effect == true:
		$Label2.text = "false"
		$CheckButton.button_pressed = false
	elif GlobalVariables.play_glitch_effect == false:
		$Label2.text = "true"
		$CheckButton.button_pressed = true

	if GlobalMusicManager.is_music_paused() == true:
		$CheckButton_for_glitch_effect2.button_pressed = true
		$pause_label.text = "true"
	else:
		$CheckButton_for_glitch_effect2.button_pressed = false
		$pause_label.text = "false"
		
	# if volume is already set to -20, then it should be reflected in the HSlider
	$HSlider.value = GlobalMusicManager.music_player.volume_db


func _on_h_slider_value_changed(value: float) -> void:
	GlobalMusicManager.get_node("music_player").volume_db = value


func _on_check_button_for_glitch_effect_2_toggled(toggled_on: bool) -> void:
	if $pause_label.text == "false":
		$pause_label.text = "true"
		GlobalMusicManager.pause_music_2()
	else:
		$pause_label.text = "false"
		GlobalMusicManager.resume_music()
