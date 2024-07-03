extends Node2D

var animationPlayer : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer = get_node("AnimationPlayer")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		animationPlayer.play("zozo_jump_to_lindsei")
