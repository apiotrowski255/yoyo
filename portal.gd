extends Area2D

# New scene to move the player too.
@export var new_scene : PackedScene

func _on_body_entered(body):
	if GlobalVariables.is_player(body):
		body.current_state = body.state.teleporting
		body.velocity = Vector2.UP * 10
		body.fade_to_clear()
		$Timer.start(2)
		$teleporting.play()
		GlobalMusicManager.fade_music(-100, 1.0)


func _on_timer_timeout():
	GlobalVariables.scene_changed(new_scene)
	GlobalMusicManager.scene_changed(new_scene)
	get_tree().change_scene_to_packed(new_scene)
