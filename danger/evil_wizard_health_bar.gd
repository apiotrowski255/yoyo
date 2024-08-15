extends Node2D


var life = 3
@onready var black_box = $BlackBox

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func take_hit():
	if life <= 0:
		return
	life -= 1
	var tween = self.create_tween()
	tween.tween_property(black_box, "scale", Vector2(black_box.scale.x + 2.5, 1), 1.0)
	tween.play()
	# black_box.scale.x += 2.5
