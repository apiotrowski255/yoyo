extends CharacterBody2D

var ACCELERATION = 25.0
var speed = 20.0

enum state {attack, crouch, crushed, idle, jump, walk}
var current_state
var animatedsprite : AnimatedSprite2D
var timer : Timer

var jump_velocity = -75


@onready var raycast_down = $raycast_down
@onready var raycast_left = $raycast_left
@onready var raycast_right = $raycast_right
@onready var raycast_up = $raycast_up


func _ready():
	current_state = state.idle
	animatedsprite = $blue_animated_sprite
	animatedsprite.play("idle")
	timer = $Timer
	velocity.x = -speed
	timer.start(3.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state == state.idle:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)
		apply_gravity(delta)
		move_and_slide()
		return
	elif current_state == state.walk:
		if animatedsprite.flip_h == true:
			velocity.x = move_toward(velocity.x, speed, ACCELERATION * delta)
		elif animatedsprite.flip_h == false:
			velocity.x = move_toward(velocity.x, -speed, ACCELERATION * delta)
		# Colliding with the left
		if raycast_left.is_colliding() == true:
			velocity.x = speed
			animatedsprite.flip_h = true
		elif raycast_right.is_colliding() == true:
			velocity.x = -speed
			animatedsprite.flip_h = false
			
		apply_gravity(delta)
		move_and_slide()
		return
	elif current_state == state.jump:
		apply_gravity(delta)
		move_and_slide()
		pass
	elif current_state == state.crushed:
		pass
	elif current_state == state.crouch:
		pass
	elif current_state == state.attack:
		pass

func switch_state(new_state : String):
	# {attack, crouch, crushed, idle, jump, walk}
	# How do i do this better?
	if current_state != state.jump and new_state == "jump":
		animatedsprite.position.y -= 8
	elif current_state == state.jump and new_state != "jump":
		animatedsprite.position.y += 8
	
	if new_state == "attack":
		current_state = state.attack
	elif new_state == "crouch":
		current_state = state.crouch
	elif new_state == "crushed":
		current_state = state.crushed
	elif new_state == "idle":
		current_state = state.idle
	elif new_state == "jump":
		current_state = state.jump
		velocity.y = jump_velocity
		
	elif new_state == "walk":
		current_state = state.walk
	animatedsprite.play(new_state)
	


func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += get_slime_gravity() * delta
		
func get_slime_gravity():
	return 100.0

func _on_timer_timeout():
	# print("Switch state")
	if current_state == state.idle:
		switch_state("walk")
	elif current_state == state.walk:
		switch_state("jump")
	#timer.stop()


func _on_animated_sprite_2d_animation_finished():
	if current_state == state.jump:
		switch_state("idle")
	pass # Replace with function body.
