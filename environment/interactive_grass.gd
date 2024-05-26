extends Area2D

var sprite : Sprite2D
@export var type : int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("grass")
	if type > 1:
		sprite.texture = load("res://sprites/grass_" + str(type) + "_1.png")
	# print(sprite.texture.get_path().get_file())

func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		sprite.texture = load("res://sprites/grass_" + str(type) + "_2.png")


func _on_body_exited(body):
	if body.get_class() == "CharacterBody2D":
		sprite.texture = load("res://sprites/grass_" + str(type) + "_1.png")
