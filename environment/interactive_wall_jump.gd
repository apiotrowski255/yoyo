extends Area2D

var sprite : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("Sprite2D")

func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		sprite.texture = load("res://sprites/wall_jump2.png")


func _on_body_exited(body):
	if body.get_class() == "CharacterBody2D":
		sprite.texture = load("res://sprites/wall_jump1.png")
