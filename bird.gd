extends Node2D

var animatedsprite : AnimatedSprite2D

enum state {idle, eating, flying}
var current_state
var timer : Timer

@export var fly_direction : Vector2 = Vector2.LEFT
var fly_speed = 75
@export var idle_sound_effect = true # If set to true - Player will hear chirping sound when near the bird


# Called when the node enters the scene tree for the first time.
func _ready():
	animatedsprite = get_node("AnimatedSprite2D")
	animatedsprite.play("idle")
	current_state = state.idle
	timer = get_node("Timer")
	timer.start(3.0)
	fly_direction = fly_direction.normalized()
	if idle_sound_effect == true:
		$idle_chirping.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state == state.idle:
		pass
	elif current_state == state.eating:
		pass
	elif current_state == state.flying:
		# Move in a direction
		position += fly_direction * delta * fly_speed



func _on_timer_timeout():
	if current_state == state.idle:
		var random_number = randi_range(1, 10)
		if random_number <= 2:
			current_state = state.eating
			animatedsprite.play("eating")
			timer.stop()
	elif current_state == state.flying:
		self.queue_free()


func _on_animated_sprite_2d_animation_finished():
	if current_state == state.eating:
		current_state = state.idle
		animatedsprite.play("idle")
		timer.start()


func _on_area_2d_body_entered(body):
	if GlobalVariables.is_player(body) and current_state != state.flying:
		fly_away()

func fly_away() -> void:
	current_state = state.flying
	animatedsprite.play("flying")
	timer.stop()
	timer.start(5)
	fly_speed = randi_range(80, 100)
	fly_direction.y = randf_range(-0.4, -1.0)
	fly_direction.x = randf_range(-1.0, 1.0)
	fly_direction = fly_direction.normalized()
	if fly_direction.x > 0:
		animatedsprite.flip_h = true
	else:
		animatedsprite.flip_h = false
	$fly_away.play()
