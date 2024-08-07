extends Node2D

@export var time_up : float = 2.0
@export var time_down : float = 2.0
@export var animation_time_length : float = 0.2
var tween_scale : Tween
@onready var _16_bit_spike = $"16-bit-spike"
var y_scale : float
var state : String
@onready var timer = $Timer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	tween_scale = self.create_tween()
	y_scale = $"16-bit-spike".scale.y
	tween_scale.finished.connect(timer_start)
	spike_down()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spike_down():
	if tween_scale:
		tween_scale.kill()
		tween_scale = self.create_tween()
		tween_scale.finished.connect(timer_start)
	tween_scale.tween_property(_16_bit_spike, "scale", Vector2(1,0), animation_time_length).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween_scale.play()
	state = "down"
	_16_bit_spike.get_child(0).disable()
	audio_stream_player_2d.play()


func spike_up():
	if tween_scale:
		tween_scale.kill()
		tween_scale = self.create_tween()
		tween_scale.finished.connect(timer_start)
	tween_scale.tween_property(_16_bit_spike, "scale", Vector2(1,y_scale), animation_time_length).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween_scale.play()
	state = "up"
	_16_bit_spike.get_child(0).enable()
	audio_stream_player_2d.play()

func timer_start():
	if state == "up":
		timer.start(time_up)
	elif state == "down":
		timer.start(time_down)


func _on_timer_timeout():
	if state == "up":
		spike_down()
	elif state == "down":
		spike_up()
	

