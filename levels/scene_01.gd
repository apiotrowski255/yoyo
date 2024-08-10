extends Node2D

var timer

# Default checkpoints_enabled to be true
@export var checkpoints_enabled : bool = true
var flag_container

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.start_camera_smoothing_timer()
	timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
	
	if checkpoints_enabled == false:
		return
	
	flag_container = get_node("flags")

	# Deactivate the already touched flags
	var i = 0
	while i <= GlobalVariables.checkpoint_counter:
		flag_container.get_child(i).already_activate()
		i += 1

	# Set player position to be based off checkpoint_counter
	$Player.global_position = flag_container.get_child(GlobalVariables.checkpoint_counter).get_player_spawn_position()

func _on_death_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		# print("do death animation")
		body.die()
		timer.start(1.5)

func _on_timer_timeout():
	get_tree().reload_current_scene()

func _on_area_2d_4_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		body.change_state(body.state.gliding)
		# body.current_state = body.state.gliding
		body.set_camera_bottom_margin(0.0)


func _on_area_2d_4_body_exited(body):
	if body.get_class() == "CharacterBody2D":
		body.change_state(body.state.normal)
		# body.current_state = body.state.normal
		body.set_camera_bottom_margin(0.6)


func _on_path_2d_kill_player(body):
	_on_death_body_entered(body)

