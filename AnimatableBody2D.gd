extends AnimatableBody2D

var timer
var direction = Vector2.RIGHT
@export var start_position = Vector2(0,0)
@export var end_position = Vector2(0,0)
@export var speed = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = global_position
	# timer = $Timer2
	# timer.start(2.0)
	direction = start_position.direction_to(end_position)
	pass # Replace with function body.



func _physics_process(delta):
	move_and_collide(direction * speed * delta)
	if position.distance_to(end_position) < 1:
		var tmp = start_position
		start_position = end_position
		end_position = tmp
		direction = -direction

func _on_timer_2_timeout():
	# direction = -direction
	# timer.start(3.0)
	pass
