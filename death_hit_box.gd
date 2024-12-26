extends Area2D

func disable():
	$CollisionShape2D.disabled = true
	
func enable():
	$CollisionShape2D.disabled = false

func _on_body_entered(body):
	if GlobalVariables.is_player(body) and body.current_state != player.state.dying:
		var scene = GlobalVariables.get_game_scene()
		if scene.name.match("*scene*"):
			scene._on_death_body_entered(body)
		else: 
			get_tree().reload_current_scene()
