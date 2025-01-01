extends Control

func _ready() -> void:
	var mouse_position = get_viewport().get_mouse_position() / 10
	$mountain_dusk_parallax.scroll_offset = mouse_position
	print(GlobalVariables.current_level)
	if GlobalVariables.current_level == null:
		$CenterContainer/MarginContainer/VBoxContainer/continue.disabled = true
		$CenterContainer/MarginContainer/VBoxContainer/continue.disconnect("mouse_entered", _on_play_mouse_entered)


func _on_play_pressed() -> void:
	GlobalMusicManager.play_menu_button_pressed_sfx()
	$CenterContainer/MarginContainer/VBoxContainer/Play.disabled = true
	$CenterContainer/MarginContainer/VBoxContainer/continue.disabled = true
	$CenterContainer/MarginContainer/VBoxContainer/Options.disabled = true
	$CenterContainer/MarginContainer/VBoxContainer/Exit.disabled = true
	GlobalMusicManager.fade_music(-100, 1.0)
	GlobalVariables.checkpoint_counter = 0
	GlobalVariables.current_level = 1
	GlobalVariables.current_sub_level = 1
	fade_to_black()

func _process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position() / 10
	$mountain_dusk_parallax.scroll_offset = mouse_position


func _on_options_pressed() -> void:
	GlobalMusicManager.play_menu_button_pressed_sfx()
	get_tree().change_scene_to_file("res://levels/options_menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func fade_to_black() -> void:
	$ColorRect.mouse_filter = MouseFilter.MOUSE_FILTER_STOP
	$AnimationPlayer.play("fade_to_black")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		GlobalMusicManager.stop()
		get_tree().change_scene_to_file("res://levels/cutscenes/cutscene_01_01.tscn")


func _on_play_mouse_entered() -> void:
	GlobalMusicManager.play_mouse_over_button_sfx()


func _on_options_mouse_entered() -> void:
	GlobalMusicManager.play_mouse_over_button_sfx()


func _on_exit_mouse_entered() -> void:
	GlobalMusicManager.play_mouse_over_button_sfx()


func _on_continue_pressed() -> void:
	GlobalVariables.load_level_from_save()
