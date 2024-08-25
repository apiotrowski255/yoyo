extends Node2D

@export var rays = 16 # starts from down direction
@export var angle_offset = 0
var timed_enemy_spawner_object = preload("res://timed_enemy_spawner.tscn")

# Defaults
@export var repeat_time : float = 2
@export var time_to_die = 10
@export var timed_enemy_speed = 32

# If master_time_to_die is negative, this object will never queue_free
@export var master_time_to_die = -1
# rotates the radian spawner by PI/ray every spawn when set to true
@export var rotate_spawn : bool = false
@export var master_rotation_speed : float = 0.0

var timer : Timer
var rays_array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_node("Timer")
	var i = 0
	var current_angle = Vector2.DOWN
	current_angle = current_angle.rotated(angle_offset)
	var angle_difference = 2 * PI / rays
	while i < rays:
		var temp = timed_enemy_spawner_object.instantiate()
		temp.spawn_direction = current_angle
		temp.repeat_time = repeat_time
		temp.time_to_die = time_to_die
		temp.timed_enemy_speed = timed_enemy_speed
		temp.play_spawn_sfx = false
		temp.hide_cannon_sprite = true
		temp.name = "ray" + str(i)
		self.add_child(temp)
		# we only need one signal from one of the emitters
		if i == rays - 1 and rotate_spawn == true:
			temp.timer.connect("timeout", _timeout)
		i += 1
		current_angle = current_angle.rotated(angle_difference)
		rays_array.append(temp)
	if master_time_to_die > 0:
		timer.start(master_time_to_die)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if master_rotation_speed != 0.0:
		self.rotate(master_rotation_speed)
	pass

func _timeout():
	for ray in rays_array:
		ray.spawn_direction = ray.spawn_direction.rotated(PI / rays)


func _on_timer_timeout():
	for ray in rays_array:
		ray.exit()
	# self.queue_free()
	# Figure out this shit
