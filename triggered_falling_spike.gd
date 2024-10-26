extends Node2D

@onready var death_hit_box = $death_hit_box
@export var time_to_fall: float = 1.0
@export var spawn_adjacent_projectiles : bool = false
var tween
# Called when the node enters the scene tree for the first time.

func _on_trigger_body_entered(body):
	if GlobalVariables.is_player(body):		
		
		if tween == null:
			$death_hit_box/Sprite2D.texture = load("res://sprites/timed_enemy2.png")
			tween = create_tween()
			tween.tween_property(death_hit_box, "position", Vector2(0, 0), time_to_fall).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
			tween.play()
			tween.connect("finished", tween_finished)
			$death_hit_box/AudioStreamPlayer2D.pitch_scale = randf_range(1.5, 2)
			$death_hit_box/AudioStreamPlayer2D.play()
			$death_hit_box/Sprite2D/ColorRect.self_modulate = Color(160, 0, 0, 160)

func tween_finished():
	var death_particles_scene = preload("res://particle_effects/enemy_die_particle_effect.tscn")
	var death_particles = death_particles_scene.instantiate()
	death_particles.global_position = self.global_position
	death_particles.emitting = true
	get_node("/root/").get_child(2).add_child(death_particles)
	
	
	spawn_sound("res://sounds/sfx/The Essential Retro Video Game Sound Effects Collection [512 sounds] By Juhani Junkala/Movement/Jumping and Landing/sfx_movement_jump9_landing.wav", 15.0)
	
	if spawn_adjacent_projectiles == true:
		spawn_timed_enemy(Vector2.RIGHT)
		spawn_timed_enemy(Vector2.LEFT)
		# Spawn sound too
		spawn_sound("res://sounds/sfx/The Essential Retro Video Game Sound Effects Collection [512 sounds] By Juhani Junkala/Weapons/Cannon/sfx_wpn_cannon2.wav", 0.0)

	
	self.queue_free()

func spawn_sound(sound_resource_name : String, volume_db: float):
	var sound = AudioStreamPlayer2D.new()
	sound.name = "temp_sound"
	sound.volume_db = volume_db
	sound.pitch_scale = randf_range(0.5, 1.5)
	sound.stream = load(sound_resource_name)
	sound.global_position = self.global_position
	sound.autoplay = true
	sound.max_distance = 400
	# sound.play()
	sound.connect("finished", sound.queue_free)
	get_node("/root/").get_child(2).add_child(sound)

func spawn_timed_enemy(direction : Vector2):
	var obj = load("res://timed_enemy.tscn")
	var obj1 : timed_enemy = obj.instantiate()
	obj1.global_position = self.global_position
	obj1.direction = direction
	obj1.speed = 256
	obj1.time_to_die = 1.0
	get_node("/root/").get_child(2).add_child(obj1)
