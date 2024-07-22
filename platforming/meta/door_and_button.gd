extends Node2D

var sprite2d : Sprite2D
var button : Area2D

func _ready():
	sprite2d = get_node("Sprite2D")
	button = get_node("button")


func _on_button_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		if sprite2d.visible == true:
			# print("play sound effect")
			sprite2d.visible = false
			$StaticBody2D/Door/AudioStreamPlayer2D.play()
