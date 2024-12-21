class_name player extends CharacterBody2D


@export var coyote_time : float = 0.15
const SPEED = 100.0
var ACCELERATION = 1000.0

var push_force = 80.0

var platform_velocity = Vector2.ZERO

var camera : Camera2D 

enum state {normal, climb, dying, sliding, in_air, jumping, 
			wall_jump_left, wall_jump_right, teleporting, gliding, shell, cutscene
			, wall_stick_left, wall_stick_right,
			line_riding }
# teleporting = pipe travelling?
# invincible mode?
var current_state = state.normal

var coyote_timer : float  = 0.0
var jump_buffer_timer : float = 0.0
var raycast_up : RayCast2D
var raycast_down : RayCast2D
var timer : Timer
var cooldown_timer : Timer
var jump_particles : CPUParticles2D

var noDown : bool # boolean variable to determine if the player can move through a one way platform. 
var noShellMode : bool

var zozosprite : Sprite2D


# https://www.youtube.com/watch?v=IOe1aGY6hXA
@export var jump_height : float = 50
@export var jump_time_to_peak : float = 0.5
@export var jump_time_to_descent : float = 0.4

@onready var jump_velocity :float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var gravity_modifier : float = 1.0

func _process(delta):
	coyote_timer -= delta
	jump_buffer_timer -= delta

func calculate_jump_parameters() -> void:
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
	jump_gravity  = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
	fall_gravity  = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func _ready():
	# gravity = 300
	camera = $Camera2D
	raycast_up = $RayCast2D
	raycast_down = $RayCast2D2
	zozosprite = $"Zozo Sprite"
	timer = get_node("Timer")
	cooldown_timer = get_node("cooldown_timer")
	noDown = false
	noShellMode = true
	jump_particles = $CPUParticles2D
	randomize()
	get_parent().set_player_position_for_checkpoint()
	start_camera_smoothing_timer(1.0)

func set_camera():
	camera.zoom = Vector2(0.5, 0.5)
	camera.drag_horizontal_enabled = false
	camera.drag_vertical_enabled = false

func get_player_gravity():
	if velocity.y < 0.0:
		return jump_gravity * gravity_modifier
	else:
		return fall_gravity * gravity_modifier

func _physics_process(delta):
	if current_state == state.climb:
		climb_state_process(delta)
		return
	elif current_state == state.wall_jump_right:
		wall_jump_right_state_process(delta)
		return
	elif current_state == state.wall_jump_left:
		wall_jump_left_state_process(delta)
		return
	elif current_state == state.dying:
		dying_state_process(delta)
		return
	elif current_state == state.line_riding:
		return
	elif current_state == state.teleporting:
		# Maybe like a slow glide up?
		# print("TODO - teleporting")
		move_and_slide()
		return
	elif current_state == state.in_air:
		if Input.is_action_just_pressed("ui_accept") and coyote_timer > 0 and velocity.y >= 0:
			velocity.y = jump_velocity
			play_jump_sfx()
		elif Input.is_action_just_pressed("e") and timer.is_stopped() == true and noShellMode == false:
			change_state(state.shell)
		elif Input.is_action_just_pressed("ui_accept"):
			jump_buffer_timer = 0.15
			
			
			
		apply_gravity(delta)
		
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction != 0 and abs(velocity.x) < SPEED:
			velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
		elif is_on_floor():
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)
		elif not is_on_floor() and Input.is_action_just_pressed("ui_left") and velocity.x > 0:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)
		elif not is_on_floor() and Input.is_action_just_pressed("ui_right") and velocity.x < 0:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)
		
		move_and_slide()
		
		if is_on_floor():
			current_state = state.normal
		elif raycast_down.get_collider() != null:
			current_state = state.sliding


		handle_collision_with_RigidBodies()
	elif current_state == state.sliding:
		sliding_state_process(delta)
		return
	elif current_state == state.cutscene:
		# Maybe apply gravity? 
		apply_gravity(delta)
		velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)
		move_and_slide()
		return
	elif current_state == state.gliding:
		apply_gravity(delta)
		velocity.y = clamp(velocity.y, -80, 80)
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction != 0:
			velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta * 0.04)
		move_and_slide()
	elif current_state == state.shell:
		apply_gravity(delta)
		move_and_slide()
	else: 
		# The normal state?
		
		# Jump buffer 
		if jump_buffer_timer > 0:
			jump_buffer_timer = 0
			velocity.y = jump_velocity
			play_jump_sfx()
			current_state = state.in_air
			return
		
		
		if Input.is_action_just_pressed("e") and timer.is_stopped() == true and noShellMode == false:
			# print("go into shell mode!")
			change_state(state.shell)
			return
		
		if not is_on_floor():
			current_state = state.in_air
			coyote_timer = coyote_time
			return
		
		# Add the gravity.
		apply_gravity(delta)
		
		# Handle jump.
		handle_jump()
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction != 0 and abs(velocity.x) < SPEED:
			velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
		elif is_on_floor():
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)
		elif not is_on_floor() and Input.is_action_just_pressed("ui_left") and velocity.x > 0:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)
		elif not is_on_floor() and Input.is_action_just_pressed("ui_right") and velocity.x < 0:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)

		move_and_slide()
		
		# go through a one way platform. 
		if Input.is_action_just_pressed("ui_down") and noDown == false:
			position.y += 1
			
		
		handle_collision_with_RigidBodies()
		
		if raycast_up.get_collider():
			if raycast_up.get_collider().get_class() == "RigidBody2D":
				if raycast_up.get_collider().position.x >= position.x:
					raycast_up.get_collider().apply_central_impulse(Vector2.RIGHT * 20)
				else:
					raycast_up.get_collider().apply_central_impulse(Vector2.LEFT * 20)
		
		if raycast_down.get_collider():
			if raycast_down.get_collider().get_class() == "RigidBody2D":
				# print("player is on top of a RigidBody2D")
				var tmp_x = position.x - raycast_down.get_collider().position.x
				var tmp_y = position.y - raycast_down.get_collider().position.y
				raycast_down.get_collider().apply_impulse(Vector2.DOWN * push_force / 4, Vector2(tmp_x, tmp_y))
	handle_sprite_rotation_and_scale()
	
	# I might have to remove this part
	# if is_on_floor_only():
	# 	zozosprite.rotation = get_floor_normal().angle() + PI/2

func change_state(state_change):
	if state_change == state.shell:
		current_state = state.shell
		$CPUParticles2D2.emitting = true
		zozosprite.self_modulate = Color(0, 0, 0)
		jump_time_to_descent = 0.2
		velocity.x = 0
		velocity.y = 0
		calculate_jump_parameters()
		timer.start(1.0)
		noShellMode = true
	# TODO - FIX THIS SHIT BELOW
	# HOW CAN SOMETHING BE IN TWO STATES?
	# I think it is supposed to be that i am not able to enter shell state while gliding
	# It is not in two states at once dummy, state_change and current_state and two different things
	elif state_change == state.gliding and current_state == state.shell:
		current_state = state.gliding
		zozosprite.self_modulate = Color(1, 1, 1)
		jump_time_to_descent = 0.4
		calculate_jump_parameters()
	elif state_change == state.line_riding:
		zozosprite.texture = load("res://sprites/zozo/zozo line ride.png")
		zozosprite.scale = Vector2(0.25, 0.25)
		zozosprite.rotation = 0
		current_state = state_change
	elif current_state == state.line_riding and state_change != state.line_riding:
		zozosprite.texture = load("res://sprites/zozo/zozo jump_1.png")
		current_state = state_change
	else:
		current_state = state_change
	return

func set_state_to_cutscene():
	current_state = state.cutscene
	self.scale = Vector2.ONE
	zozosprite.rotation = 0
	zozosprite.scale = Vector2(0.25, 0.25)
	

func wall_jump_left_state_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_velocity
		velocity.x = -100
		$sfx/jump.pitch_scale = randf_range(0.9, 1.1)
		$sfx/jump.play()
	elif Input.is_action_pressed("ui_left"):
		velocity.x = move_toward(velocity.x, SPEED * -1, ACCELERATION * delta)
	reset_sprite_scale()
	zozosprite.rotation = 0
	zozosprite.scale.x = -0.25
	apply_gravity(delta)
	move_and_slide()

func wall_jump_right_state_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_velocity
		velocity.x = 100
		$sfx/jump.pitch_scale = randf_range(0.9, 1.1)
		$sfx/jump.play()
	elif Input.is_action_pressed("ui_right"):
		velocity.x = move_toward(velocity.x, SPEED * 1, ACCELERATION * delta)
	reset_sprite_scale()
	zozosprite.rotation = 0
	zozosprite.scale.x = 0.25
	apply_gravity(delta)
	move_and_slide()

func dying_state_process(delta):
	velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta / 4)
	velocity.y = move_toward(velocity.y, 0, ACCELERATION * delta / 4)
	move_and_slide()

func handle_collision_with_RigidBodies():
	# Sauce
	# https://www.youtube.com/watch?v=SJuScDavstM
	# Seems to work well! For pushing objects. 
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func climb_state_process(delta):
	apply_friction(delta)
	handle_jump()
	move_down()
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)
	handle_sprite_rotation_and_scale()
	zozosprite.rotation = 0
	move_and_slide()
	return

func sliding_state_process(delta):
	if is_on_floor():
			current_state = state.normal
	elif raycast_down.get_collider() == null:
		current_state = state.in_air
	# Stuff below is to allow/test jumping while sliding
	#if Input.is_action_just_pressed("ui_accept"):
		#velocity.y -= 550
		#if velocity.x >= 0:
			#velocity.x += 175
		#elif velocity.x < 0:
			#velocity.x -= 175
	apply_gravity(delta)
	move_and_slide()

func handle_sprite_rotation_and_scale():
	
	var scale_strength = 0.025
	if velocity.length() > 90:
		scale_strength = 0.025
	elif velocity.length() > 60:
		scale_strength = 0.02
	else:
		scale_strength = 0.01
	if velocity != Vector2.ZERO:
		if velocity.y > 0 and velocity.x == 0:
			zozosprite.scale.y = 0.25 + scale_strength
			if not Input.is_action_pressed("ui_left"): # This is dumb - but it is to prevent sprite flipping in the air while colliding with platform. 
				zozosprite.scale.x = 0.25 - scale_strength
			zozosprite.rotation = 0
		elif velocity.y < 0 and velocity.x == 0:
			zozosprite.scale.y = 0.25 + scale_strength
			if not Input.is_action_pressed("ui_left"):
				zozosprite.scale.x = 0.25 - scale_strength
			zozosprite.rotation = 0
		elif velocity.y > 0 and velocity.x > 0:
			zozosprite.scale.y = 0.25 + scale_strength
			zozosprite.scale.x = 0.25 - scale_strength
			zozosprite.rotation = velocity.angle() / 8
		elif velocity.y < 0 and velocity.x > 0:
			zozosprite.scale.y = 0.25 + scale_strength
			zozosprite.scale.x = 0.25 - scale_strength
			zozosprite.rotation = velocity.angle() / 8
		elif velocity.y > 0 and velocity.x < 0:
			zozosprite.scale.y = 0.25 + scale_strength
			zozosprite.scale.x = -0.25 + scale_strength
			var tmp_velocity = velocity
			tmp_velocity.y = -tmp_velocity.y
			tmp_velocity.x = -tmp_velocity.x
			zozosprite.rotation = (tmp_velocity.angle())/8
		elif velocity.y < 0 and velocity.x < 0:
			zozosprite.scale.y = 0.25 + scale_strength
			zozosprite.scale.x = -0.25 + scale_strength
			var tmp_velocity = velocity
			tmp_velocity.y = -tmp_velocity.y
			tmp_velocity.x = -tmp_velocity.x
			zozosprite.rotation = (tmp_velocity.angle())/8
		elif velocity.x < 0 and velocity.y == 0:
			zozosprite.scale.y = 0.25 - scale_strength
			zozosprite.scale.x = -0.25 - scale_strength
			zozosprite.rotation = 0
		elif velocity.x > 0 and velocity.y == 0:
			zozosprite.scale.y = 0.25 - scale_strength
			zozosprite.scale.x = 0.25 + scale_strength
			zozosprite.rotation = 0
	else:
		reset_sprite_scale()
		zozosprite.rotation = 0

func reset_sprite_scale():
	zozosprite.scale.y = 0.25
	if zozosprite.scale.x < 0:
		zozosprite.scale.x = -0.25
	else:
		zozosprite.scale.x = 0.25
	# zozosprite.scale.x = 0.25

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += get_player_gravity() * delta

func apply_friction(delta):
	if velocity.y != 0:
		velocity.y += get_player_gravity() * delta
	if velocity.y > 0:
		velocity.y = 0

# Used for the climb process
func move_down():
	if Input.is_action_pressed("ui_down"):
		velocity.y = -jump_velocity

func handle_jump():
	if current_state == state.climb:
		if Input.is_action_pressed("ui_accept"):
			velocity.y = jump_velocity
			if $sfx/climb.playing == false:
				$sfx/climb.play()
			return
		elif $sfx/climb.playing == true:
			$sfx/climb.stop()
	if current_state != state.climb:
		$sfx/climb.stop()
	if is_on_floor() or (coyote_timer > 0 and not velocity.y < 0):
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_velocity
			play_jump_sfx()
	if is_on_floor() and coyote_timer > 0:
		pass

# Kill the player and restart the level
# I think we need the origin the object that killed the player
# But might be too hard to implement now
func die():
	if current_state == state.dying:	# We are already dying damn it!
		return
	
	# print("play death glitch animation")
	# var random_scale = (randf() + 1)
	var random_scale = 1
	velocity.x = -velocity.x * random_scale
	velocity.y = -velocity.y * random_scale
	velocity = velocity.normalized() * 175
	if velocity == Vector2.ZERO:
		velocity = Vector2.UP * 175
	current_state = state.dying
	$sfx/death.play()
	$Control.visible = GlobalVariables.play_glitch_effect # This is what makes the glitch effect!
							# Might need to change the Shake Rate
							# Maybe possible to disable via options menu
	$death_particles.emitting = true
	
func do_a_flip():
	var tween = self.get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees", 360, .75)

func set_camera_bottom_margin(value):
	camera.drag_bottom_margin = value

func _on_timer_timeout():
	# Exit the shell state
	if current_state == state.shell:
		current_state = state.normal
		zozosprite.self_modulate = Color(1, 1, 1)
		jump_time_to_descent = 0.4
		calculate_jump_parameters()
		cooldown_timer.start(2.0)
	#elif particles.emitting == true:
	#	particles.emitting = false
	timer.stop()



func _on_cooldown_timer_timeout():
	# Allow the player to go into the shell state.
	$CPUParticles2D3.emitting = true
	noShellMode = false
	cooldown_timer.stop()


# disables smoothing on the camera, and then on timeout will re-enable smoothing
# Might use it for multiple things in the future - but will see
func start_camera_smoothing_timer(time : float):
	$Camera_smoothing_timer.start(time)
	camera.position_smoothing_enabled = false

func _on_camera_smoothing_timer_timeout():
	camera.position_smoothing_enabled = true

func play_stomp_sfx():
	$sfx/enemy_stomped.play()

func change_stomp_sfx_random():
	var i = randi_range(1, 9)
	var string = "sfx_exp_shortest_soft" + str(i) + ".wav"
	$'sfx/enemy_stomped'.stream = load("res://sounds/sfx/The Essential Retro Video Game Sound Effects Collection [512 sounds] By Juhani Junkala/Explosions/Shortest/" + string)


func _on_enemy_stomped_finished():
	change_stomp_sfx_random()

func play_jump_sfx():
	$sfx/jump.pitch_scale = randf_range(0.9, 1.1)
	$'sfx/jump'.play()

# fade to clear
# Used when the player touches a teleporter
func fade_to_clear():
	var tween = create_tween()
	tween.tween_property(zozosprite, "self_modulate", Color(1.0, 1.0, 1.0, 0.0), 2.0)
	

func set_camera_position(new_position : Vector2):
	camera.position = new_position

func camera_shake_01(duration : float, offset: Vector2) -> void:
	var tween = create_tween()
	self.camera.offset = offset
	tween.tween_property(self.camera, "offset", Vector2(0,0), duration).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
