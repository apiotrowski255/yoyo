extends Node2D

@export var time_to_finish_line_ride : float = 2.0
@export var exit_velocity : Vector2 = Vector2(200, -100)

var tmp_parent
var local_player : player

func _on_area_2d_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		local_player = body
		
		local_player.change_state(player.state.line_riding)
		
		# local_player.start_camera_smoothing_timer(3.0)
		
		# get_node("Path2D/PathFollow2D").add_child(local_player)
		# print(get_node("Path2D/PathFollow2D").get_children())
		var tween = create_tween()
		tween.tween_property(get_node("Path2D/PathFollow2D"), "progress_ratio", 1, time_to_finish_line_ride)
		tween.connect("finished", _on_tween_finished)
		$Path2D/PathFollow2D/sfx.pitch_scale = randf_range(0.8, 1.2)
		$Path2D/PathFollow2D/sfx.play()


func _process(delta: float) -> void:
	
	
	# sucks so much we are doing this check every frame...
	# But reparenting the player does not work since it screws up the camera
	if local_player != null and local_player.current_state == player.state.line_riding:
		local_player.global_position = $Path2D/PathFollow2D.global_position
		# print($Path2D/PathFollow2D.rotation)
		local_player.rotation = $Path2D/PathFollow2D.rotation


func _on_tween_finished():
	if local_player.current_state == player.state.dying:
		$Path2D/PathFollow2D/sfx.stop()
		return
	
	local_player.position = get_global_position_of_last_point()
	local_player.reparent(get_node("/root").get_child(3)) # reparent to scene node
	local_player.change_state(player.state.in_air)
	local_player.velocity = exit_velocity
	local_player.rotation = 0
	local_player = null
	$Path2D/PathFollow2D/sfx.stop()
	$Path2D/PathFollow2D.progress_ratio = 0

# When doing this, we cannot have any local rotation to the object
func get_global_position_of_last_point() -> Vector2:
	return $Path2D.get_curve().sample($Path2D.get_curve().get_point_count(), 0) + global_position
