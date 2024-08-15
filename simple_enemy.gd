extends CharacterBody2D
@export var speed = 50.0
var direction = Vector2.LEFT

var rightcast : RayCast2D
var leftcast : RayCast2D

var sprite : Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = direction * speed
	rightcast = $Rightcast
	leftcast = $Leftcast
	sprite = $Sprite2D

func _physics_process(delta):
	
	if is_on_wall():
		switch_direction()
	elif leftcast.get_collider() == null and rightcast.get_collider() != null:
		switch_direction()
	elif leftcast.get_collider() != null and rightcast.get_collider() == null:
		switch_direction()
	
	apply_gravity(delta)
	move_and_slide()

func switch_direction():
	direction = -direction
	velocity = direction * speed
	sprite.scale.x = -sprite.scale.x

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta / 2

func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D" and body.current_state == body.state.shell:
		print("collided with player - but player is in shell state")
	elif body.get_class() == "CharacterBody2D" and body.name == "Player" and body.current_state != body.state.dying:
		# need to dynamically get the level the player is on
		# the number 2 might need to change depending on how many global
		# scripts there are.
		get_node("/root").get_child(2)._on_death_body_entered(body)
		print("most likely the player - gotta kill the player")


func _on_stomp_body_entered(body):
	if GlobalVariables.is_player(body):
		
		# print("enemy die animation")
		# Or we can do a particle effect for when an enemy dies? 
		var death_particles_scene = preload("res://particle_effects/enemy_die_particle_effect.tscn")
		var death_particles = death_particles_scene.instantiate()
		death_particles.global_position = self.global_position
		death_particles.emitting = true
		# print(death_particles.position)
		# print(get_node("/root/scene_01")) # This will need to change depending on the scene number - TODO for later.
		get_node("/root/").get_child(2).add_child(death_particles)
		# get_node("/root/scene_01").add_child(death_particles)
		if body.current_state != body.state.shell:
			body.velocity.y = -250
		# self.queue_free()
		

		# Play the sfx
		# sfx has to be played on the player object
		body.play_stomp_sfx()
		
		self.queue_free()
