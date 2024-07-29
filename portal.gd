extends Area2D

@export var new_scene : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D" and body.name == "Player":
		body.current_state = body.state.teleporting
		body.velocity = Vector2.UP * 10
		body.fade_to_clear()
		$Timer.start(2)
		$teleporting.play()
	pass # Replace with function body.


func _on_timer_timeout():
	GlobalVariables.scene_changed(new_scene)
	GlobalMusicManager.scene_changed(new_scene)
	get_tree().change_scene_to_packed(new_scene)
	pass # Replace with function body.
