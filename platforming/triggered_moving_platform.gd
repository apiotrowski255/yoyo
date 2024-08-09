extends AnimatableBody2D

# When the player is on the platform, it will move
# When the player jumps off the platform, it will stop. 

var direction = Vector2.RIGHT
@export var start_position = Vector2(0,0)
@export var end_position = Vector2(0,0)
@export var speed = 50
enum state {idle, moving}
var current_state



# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = position
	direction = start_position.direction_to(end_position)
	current_state = state.idle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state == state.idle:
		return
	else:
		move_and_collide(direction * speed * delta)
		if position.distance_to(end_position) < 1:
			var tmp = start_position
			start_position = end_position
			end_position = tmp
			direction = -direction



func _on_trigger_area_body_entered(body):
	if body.get_class() == "CharacterBody2D" and body.name == "Player" and body.current_state != body.state.dying:
		current_state = state.moving



func _on_trigger_area_body_exited(body):
	if body.get_class() == "CharacterBody2D" and body.name == "Player" and body.current_state != body.state.dying:
		current_state = state.idle

