extends StaticBody2D

@export var time_to_die : float = 7.0
@export var speed : float = 32.0
@export var direction : Vector2 = Vector2.DOWN

var timer : Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = $Timer
	timer.start(time_to_die)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	position += direction * speed * delta


func _on_timer_timeout():
	self.queue_free()
	pass # Replace with function body.
