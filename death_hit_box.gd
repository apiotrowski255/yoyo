extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func disable():
	$CollisionShape2D.disabled = true
	
func enable():
	$CollisionShape2D.disabled = false

func _on_body_entered(body):
	if GlobalVariables.is_player(body):
		# Still pretty bad code, because it means that the scene script needs to 
		# handle the player's death. Which is kind of true.
		var scene = get_node("/root/").get_child(2)
		if scene.name.match("*scene*"):
			get_node("/root/").get_child(2)._on_death_body_entered(body)
		else: 
			get_tree().reload_current_scene()
