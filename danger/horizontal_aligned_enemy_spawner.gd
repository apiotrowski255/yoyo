extends Node2D


var target
var spawn_location
var timer : Timer
@export var enemy_scene: PackedScene
@export var spawner_move_speed = 64.0
@export var projectile_speed = 256.0
var line2d : Line2D
var animationplayer : AnimationPlayer
var particles : CPUParticles2D
@export var line_length : float = 64
# Called when the node enters the scene tree for the first time.
func _ready():
	target = null
	spawn_location = get_node("Sprite2D")
	timer = get_node("Timer")
	timer.stop()
	line2d = get_node("Line2D")
	line2d.add_point(spawn_location.position)
	animationplayer = get_node("AnimationPlayer")
	particles = get_node("Sprite2D/CPUParticles2D")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target == null:
		return
	var angle = spawn_location.global_position.angle_to_point(target.global_position)
	angle = angle - self.rotation
	if abs(angle) < 0.01:
		return
	elif angle > 0:
		spawn_location.position.y = move_toward(spawn_location.position.y, spawn_location.position.y + 32,  spawner_move_speed * delta)
	elif angle < 0:
		spawn_location.position.y = move_toward(spawn_location.position.y, spawn_location.position.y - 32,  spawner_move_speed * delta)
	line2d.set_point_position(0, spawn_location.position)
	var temp : Vector2 = spawn_location.position
	temp.x += line_length
	line2d.set_point_position(1, temp)


func _on_player_detection_area_body_entered(body):
	if GlobalVariables.is_player(body):
		target = body
		timer.start()
		var temp : Vector2 = spawn_location.position
		temp.x += line_length
		line2d.add_point(temp)
		animationplayer.play("line_colour_change")


func _on_player_detection_area_body_exited(body):
	if GlobalVariables.is_player(body):
		target = null
		timer.stop()
		line2d.remove_point(1)
		animationplayer.stop()

# Every 2 seconds we spawn a projectile
func _on_timer_timeout():
	var enemy = enemy_scene.instantiate()
	enemy.position = spawn_location.position
	enemy.time_to_die = 6.0
	enemy.direction = Vector2.RIGHT
	enemy.speed = projectile_speed
	self.add_child(enemy)
	$Sprite2D/AudioStreamPlayer2D.play()
	particles.emitting = true
