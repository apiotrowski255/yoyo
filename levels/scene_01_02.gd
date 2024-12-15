extends Node2D

var timer

# Default checkpoints_enabled to be true
@export var checkpoints_enabled : bool = true
var flag_container

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalMusicManager.fade_music(-10, 1.5)
	$Player.start_camera_smoothing_timer(1.0)
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
	if GlobalVariables.is_player(body):
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


func _on_start_cutscene_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		# start fade to black
		$AnimationPlayer.play("fade_to_black")
		$Player.set_state_to_cutscene()
		# stop global music music
		GlobalMusicManager.stop()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		# print("now play cutscene")
		get_tree().change_scene_to_file("res://levels/cutscenes/cutscene_01_03.tscn")
