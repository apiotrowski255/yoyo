extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer.visible = false
	
	

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("option_menu"):
		if in_gameplay() and GlobalVariables.get_game_scene() != null and GlobalVariables.get_game_scene().get_node("Player").current_state != player.state.cutscene:
			if $CanvasLayer.visible == false:
				# print("present options menu")
				$CanvasLayer.visible = true
				GlobalVariables.get_game_scene().process_mode = Node.PROCESS_MODE_DISABLED
				set_options()
				$CanvasLayer/pause_in.play()
			elif $CanvasLayer.visible == true:
				# print("hide options menu - resume gameplay")
				$CanvasLayer.visible = false
				GlobalVariables.get_game_scene().process_mode = Node.PROCESS_MODE_INHERIT
				$CanvasLayer/AudioStreamPlayer.play()
	elif event.is_action_pressed("esc") and $CanvasLayer.visible == true:
		$CanvasLayer.visible = false
		GlobalVariables.get_game_scene().process_mode = Node.PROCESS_MODE_INHERIT
		$CanvasLayer/AudioStreamPlayer.play()


func in_gameplay() -> bool:
	if get_parent().get_child(3).name.contains("scene") and not get_parent().get_child(3).name.contains("cutscene"):
		return true
	return false



func set_options():
	# for example if glitch effect is already turned off, then it should be turned off in the options menu
	if GlobalVariables.play_glitch_effect == true:
		$CanvasLayer/glitch_effect/glitch_effect_status.text = "false"
		$CanvasLayer/glitch_effect/CheckButton_for_glitch_effect.button_pressed = false
	elif GlobalVariables.play_glitch_effect == false:
		$CanvasLayer/glitch_effect/glitch_effect_status.text = "true"
		$CanvasLayer/glitch_effect/CheckButton_for_glitch_effect.button_pressed = true

	if GlobalMusicManager.is_music_paused() == true:
		$CanvasLayer/CheckButton_for_glitch_effect2.button_pressed = true
		$CanvasLayer/pause_label.text = "true"
	else:
		$CanvasLayer/CheckButton_for_glitch_effect2.button_pressed = false
		$CanvasLayer/pause_label.text = "false"
		
	# if volume is already set to -20, then it should be reflected in the HSlider
	$CanvasLayer/HSlider.value = GlobalMusicManager.music_player.volume_db


func _on_check_button_for_glitch_effect_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		$CanvasLayer/glitch_effect/glitch_effect_status.text = "false"
	else:
		$CanvasLayer/glitch_effect/glitch_effect_status.text = "true"
	GlobalVariables.play_glitch_effect = not toggled_on


func _on_h_slider_value_changed(value: float) -> void:
	GlobalMusicManager.get_node("music_player").volume_db = value


func _on_check_button_for_glitch_effect_2_toggled(toggled_on: bool) -> void:
	if $CanvasLayer/pause_label.text == "false":
		$CanvasLayer/pause_label.text = "true"
		GlobalMusicManager.pause_music_2()
	else:
		$CanvasLayer/pause_label.text = "false"
		GlobalMusicManager.resume_music()
