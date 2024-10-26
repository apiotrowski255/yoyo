extends AnimatableBody2D

# When the player is on the platform, it will move
# When the player jumps off the platform, it will stop. 

var direction = Vector2.RIGHT
@export var start_position = Vector2(0,0)
@export var end_position = Vector2(0,0)
@export var speed = 50
# discontinuous - Means when the player jumps off, the platform stops
# continous - Means when the player jumps off, the platform keeps moving
# once - Once platform reaches target, it will stop. 
enum type {discontiuous, continous, once}
@export var current_type = type.discontiuous
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
		#move_and_collide(direction * speed * delta)
		position = position.move_toward(end_position, delta * speed)
		if position.distance_to(end_position) == 0:
			if current_type == type.once:
				current_state = state.idle
				return
			swap_start_and_end_positions()


func swap_start_and_end_positions():
	var tmp = start_position
	start_position = end_position
	end_position = tmp
	direction = -direction

func _on_trigger_area_body_entered(body):
	if not GlobalVariables.is_player(body):
		return
	if current_state == state.idle and position.distance_to(end_position) < 1:
		return
	if GlobalVariables.is_player(body):
		current_state = state.moving



func _on_trigger_area_body_exited(body):
	if not GlobalVariables.is_player(body):
		return
	if current_type == type.continous or current_type == type.once:
		return
	if GlobalVariables.is_player(body):
		current_state = state.idle
