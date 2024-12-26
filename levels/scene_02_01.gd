extends Node2D

var timer : Timer

# Default checkpoints_enabled to be true
@export var checkpoints_enabled : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.start_camera_smoothing_timer(1.0)
	timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
	
	# self.connect()
	# $evil_wizard.evil_wizard_hit.connect(evil_wizard_hit)
	timer = $Timer

func set_player_position_for_checkpoint() -> void:
	# Deactivate the already touched flags
	var i = 0
	var flag_container = get_node("flags")
	while i <= GlobalVariables.checkpoint_counter:
		flag_container.get_child(i).already_activate()
		i += 1

	# Set player position to be based off checkpoint_counterd 
	$Player.global_position = flag_container.get_child(GlobalVariables.checkpoint_counter).get_player_spawn_position()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_death_body_entered(body):
	if GlobalVariables.is_player(body):
		# print("do death animation")
		body.die()
		timer.start(1.5)

func _on_timer_timeout():
	get_tree().reload_current_scene()



func _on_game_pause_timer_timeout() -> void:
	# Unpause the game
	self.process_mode = Node.PROCESS_MODE_INHERIT

func short_pause(time: float) -> void:
	self.process_mode = Node.PROCESS_MODE_DISABLED
	$game_pause_timer.start(time)
	
func evil_wizard_hit() -> void:
	short_pause(0.1)


func _on_start_cutscene_body_entered(body: Node2D) -> void:
	if GlobalVariables.is_player(body):
		# start fade to black
		$AnimationPlayer.play("fade_to_black")
		$Player.set_state_to_cutscene()
		# fade global music
		GlobalMusicManager.fade_music(-40, 1.0)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		print("now play cutscene")
		get_tree().change_scene_to_file("res://levels/cutscenes/yoyo_jump_to_lindsei.tscn")


func _on_path_2d_kill_player(body) -> void:
	_on_death_body_entered(body)
