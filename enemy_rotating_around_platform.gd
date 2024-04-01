extends Node2D
@onready var path_follow : PathFollow2D = $Path2D/PathFollow2D

@export var speed = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path_follow.progress += speed * delta
	pass


func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		print("gotta kill the player")
	pass # Replace with function body.
