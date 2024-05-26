extends Node2D

var target = null
var timed_enemy_spawner
var line2d : Line2D
var animationplayer : AnimationPlayer
var shot_particules : CPUParticles2D
var cannon_sprite : Sprite2D
var absorb_particles : CPUParticles2D

@export var shoot_time = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	timed_enemy_spawner = get_node("timed_enemy_spawner")
	timed_enemy_spawner.stop_spawning()
	line2d = get_node("Line2D")
	animationplayer = get_node("AnimationPlayer")
	shot_particules = get_node("Cannon/CPUParticles2D")
	cannon_sprite = get_node("Cannon")
	absorb_particles = get_node("absorb_particles")
	timed_enemy_spawner.repeat_time = shoot_time
	absorb_particles.lifetime = shoot_time
	animationplayer.speed_scale = 2 / shoot_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target == null:
		return
	else:
		var p1 : Vector2 = timed_enemy_spawner.global_position
		var p2 : Vector2 = target.position
		var spawn_direction_vector2 : Vector2 = Vector2.RIGHT.rotated(p1.angle_to_point(p2))
		timed_enemy_spawner.spawn_direction = spawn_direction_vector2
		line2d.set_point_position(1, p2 - p1)
		cannon_sprite.rotation = p1.angle_to_point(p2) - PI/2



func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		target = body
		timed_enemy_spawner.start_spawning()
		line2d.add_point(target.position - global_position)
		animationplayer.play("line_color_change")
		absorb_particles.emitting = true

func _on_area_2d_body_exited(body):
	if body.get_class() == "CharacterBody2D":
		target = null
		timed_enemy_spawner.stop_spawning()
		line2d.remove_point(1)
		animationplayer.stop()
		absorb_particles.emitting = false


func _on_timed_enemy_spawner_timed_enemy_spawned():
	shot_particules.emitting = true
	pass # Replace with function body.
