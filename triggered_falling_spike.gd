extends Node2D

@onready var death_hit_box = $death_hit_box
@export var time_to_fall: float = 1.0
var tween
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_trigger_body_entered(body):
	if body.get_class() == "CharacterBody2D" and body.name == "Player" and body.current_state != body.state.dying:
		# print("spike falling down!")
		
		
		if tween == null:
			$death_hit_box/Sprite2D.texture = load("res://sprites/timed_enemy2.png")
			tween = create_tween()
			tween.tween_property(death_hit_box, "position", Vector2(0, 0), time_to_fall).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
			tween.play()
			tween.connect("finished", tween_finished)
			$death_hit_box/AudioStreamPlayer2D.pitch_scale = 2
			$death_hit_box/AudioStreamPlayer2D.play()

func tween_finished():
	var death_particles_scene = preload("res://particle_effects/enemy_die_particle_effect.tscn")
	var death_particles = death_particles_scene.instantiate()
	death_particles.global_position = self.global_position
	death_particles.emitting = true
	get_node("/root/").get_child(2).add_child(death_particles)
	
	var sound = AudioStreamPlayer2D.new()
	sound.name = "temp_sound"
	sound.stream = load("res://sounds/sfx/The Essential Retro Video Game Sound Effects Collection [512 sounds] By Juhani Junkala/Movement/Jumping and Landing/sfx_movement_jump9_landing.wav")
	sound.global_position = self.global_position
	sound.autoplay = true
	sound.max_distance = 400
	# sound.play()
	sound.connect("finished", sound.queue_free)
	get_node("/root/").get_child(2).add_child(sound)
	
	self.queue_free()
