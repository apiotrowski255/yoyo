extends Node2D
@onready var path_follow : PathFollow2D = $Path2D/PathFollow2D

@export var speed = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path_follow.progress += speed * delta



func _on_area_2d_body_entered(body):
	if GlobalVariables.is_player(body):
		var scene = get_node("/root/").get_child(3)
		if scene.name.match("*scene*"):
			get_node("/root/").get_child(3)._on_death_body_entered(body)
		else: 
			get_tree().reload_current_scene()
