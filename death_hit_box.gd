extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D" and body.name == "Player" and body.current_state != body.state.dying:
		# Still pretty bad code, because it means that the scene script needs to 
		# handle the player's death. Which is kind of true.
		get_node("/root/").get_child(2)._on_death_body_entered(body)
