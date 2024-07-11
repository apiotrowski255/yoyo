extends Area2D

@export var door: CollisionShape2D

var sprite2d : Sprite2D
# Called when the node enters the scene tree for the first time.
var opened : bool

func _ready():
	sprite2d = $Sprite2D
	opened = false

func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D" and opened == false:
		# print("TODO: Opening door - Animate button")
		# Maybe not - just a sprite change to the button is enough i think.
		if door != null:
			door.set_deferred("disabled", true)
		sprite2d.texture = load("res://button_pressed.png")
		opened = true
		play_sfx()
		

func play_sfx():
	$AudioStreamPlayer2D.play()
