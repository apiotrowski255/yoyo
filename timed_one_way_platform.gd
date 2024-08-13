extends StaticBody2D

@export var time_to_die : float = 7.0
@export var speed : float = 32.0
@export var direction : Vector2 = Vector2.DOWN



var timer : Timer
# Called when the node enters the scene tree for the first time.
@export var sprite_number : int = 1 # Depending on the number - Change the sprite
@onready var sprite : Sprite2D 


func _ready():
	timer = $Timer
	timer.start(time_to_die)
	sprite = get_node("sprite")
	sprite.texture = load("res://sprites/one_way_platform_0" + str(sprite_number) + ".png")

func _physics_process(delta):
	position += direction * speed * delta


func _on_timer_timeout():
	self.queue_free()
	pass # Replace with function body.
