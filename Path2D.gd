extends Path2D

var path_follow : PathFollow2D
@export var speed = 50
@onready var tween : Tween
# Called when the node enters the scene tree for the first time.
@export var ease = Tween.EASE_IN_OUT
@export var trans = Tween.TRANS_SINE
@export var time = 10

signal kill_player

func _ready():
	path_follow = $PathFollow2D
	tween = get_tree().create_tween().bind_node(self)
	# tween.connect("finished", Callable(self, "tween_finished"))
	tween.set_loops()
	
	# https://www.reddit.com/r/godot/comments/11x54z2/how_to_get_tweens_to_loop_this_isnt_working_for/
	tween.tween_property(path_follow, "progress_ratio", 1, time).set_ease(ease).set_trans(trans).as_relative()

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# path_follow.progress += delta * speed
	pass



func _on_area_2d_body_entered(body):
	if body.get_class() == "CharacterBody2D" and body.current_state != body.state.dying: # Might conflict with simple enemy
		emit_signal("kill_player", body)
	pass # Replace with function body.
