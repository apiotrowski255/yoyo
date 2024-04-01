extends CharacterBody2D


@export var coyote_time : float = 0.15
const SPEED = 100.0
var ACCELERATION = 1000.0
var JUMP_VELOCITY = -300.0
var push_force = 80.0

var platform_velocity = Vector2.ZERO

var camera : Camera2D 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
enum state {normal, climb, dying, sliding, in_air, jumping, wall_jump_left, wall_jump_right, teleporting}
# teleporting = pipe travelling?
var current_state = state.normal

var coyote_timer : float  = 0.0
var raycast_up : RayCast2D
var raycast_down : RayCast2D

func _process(delta):
	coyote_timer -= delta

func _ready():
	# gravity = 300
	camera = $Camera2D
	raycast_up = $RayCast2D
	raycast_down = $RayCast2D2
	randomize()

func set_camera():
	camera.zoom = Vector2(0.5, 0.5)
	camera.drag_horizontal_enabled = false
	camera.drag_vertical_enabled = false


func _physics_process(delta):

	if current_state == state.climb:
		apply_friction(delta)
		handle_jump()
		move_down()
		
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction != 0:
			velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)

		move_and_slide()
		return
	if current_state == state.wall_jump_right:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			velocity.x = 100
		elif Input.is_action_pressed("ui_right"):
			velocity.x = move_toward(velocity.x, SPEED * 1, ACCELERATION * delta)
		apply_gravity(delta)
		move_and_slide()
		return
	if current_state == state.wall_jump_left:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			velocity.x = -100
		elif Input.is_action_pressed("ui_left"):
			velocity.x = move_toward(velocity.x, SPEED * -1, ACCELERATION * delta)
		apply_gravity(delta)
		move_and_slide()
		return
	
	elif current_state == state.dying:
		
		velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta / 4)
		velocity.y = move_toward(velocity.y, 0, ACCELERATION * delta / 4)
		move_and_slide()
	elif current_state == state.in_air:
		if Input.is_action_just_pressed("ui_accept") and coyote_timer > 0 and velocity.y > 0:
			velocity.y = JUMP_VELOCITY
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

		for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider() is RigidBody2D:
				c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
		
	elif current_state == state.sliding:
		if is_on_floor():
			current_state = state.normal
		elif raycast_down.get_collider() == null:
			current_state = state.in_air
		#if Input.is_action_just_pressed("ui_accept"):
			#velocity.y -= 550
			#if velocity.x >= 0:
				#velocity.x += 175
			#elif velocity.x < 0:
				#velocity.x -= 175
		apply_gravity(delta)
		move_and_slide()
		
	else:
		if not is_on_floor():
			current_state = state.in_air
			coyote_timer = coyote_time
		
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
		
		if Input.is_action_just_pressed("ui_down"):
			position.y += 1
			
		# https://www.youtube.com/watch?v=SJuScDavstM

		for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider() is RigidBody2D:
				c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
		
		if raycast_up.get_collider():
			if raycast_up.get_collider().get_class() == "RigidBody2D":
				if raycast_up.get_collider().position.x >= position.x:
					raycast_up.get_collider().apply_central_impulse(Vector2.RIGHT * 20)
				else:
					raycast_up.get_collider().apply_central_impulse(Vector2.LEFT * 20)
		
		if raycast_down.get_collider():
			if raycast_down.get_collider().get_class() == "RigidBody2D":
				print("here")
				var tmp_x = position.x - raycast_down.get_collider().position.x
				var tmp_y = position.y - raycast_down.get_collider().position.y
				raycast_down.get_collider().apply_impulse(Vector2.DOWN * push_force / 4, Vector2(tmp_x, tmp_y))

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func apply_friction(delta):
	if velocity.y != 0:
		velocity.y += gravity * delta
	if velocity.y > 0:
		velocity.y = 0

func move_down():
	if Input.is_action_pressed("ui_down"):
		velocity.y = -JUMP_VELOCITY

func handle_jump():
	if current_state == state.climb:
		if Input.is_action_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			return
	if is_on_floor() or (coyote_timer > 0 and not velocity.y < 0):
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY

func die():
	print("play death glitch animation")
	# var random_scale = (randf() + 1)
	var random_scale = 1
	velocity.x = -velocity.x * random_scale
	velocity.y = -velocity.y * random_scale
	velocity = Vector2.UP * 175
	current_state = state.dying
	
func do_a_flip():
	var tween = self.get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees", 360, .75)
