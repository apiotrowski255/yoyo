extends Area2D

@export var time_to_die : float = 7.0
@export var speed : float = 32.0
@export var direction : Vector2 = Vector2.DOWN

var timer : Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer
	timer.start(time_to_die)
	pass # Replace with function body.

func _physics_process(delta):
	position += direction * speed * delta

func _on_timer_timeout():
	# print("Do i want a disappear animation here?")
	self.queue_free()


func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		print("Character has been hit by timed enemy")
	pass # Replace with function body.
