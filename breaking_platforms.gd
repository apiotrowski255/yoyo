extends Node2D

@export var time_to_break = 1.5

var timer
var collisionshape
var sprite
var animationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer
	collisionshape = $StaticBody2D/CollisionShape2D
	sprite = $RotatingSide
	animationPlayer = $AnimationPlayer



func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		# print("play breaking animation - or shake the sprite")
		timer.start(time_to_break)
		animationPlayer.play("sprite_shake")


func _on_timer_timeout():
	if collisionshape.disabled == false:
		collisionshape.set_deferred("disabled", true)
		sprite.set_deferred("visible", false)
	elif collisionshape.disabled == true:
		collisionshape.set_deferred("disabled", false)
		sprite.set_deferred("visible", true)
		timer.stop()
