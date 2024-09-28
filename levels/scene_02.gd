extends Node2D

var timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	# self.connect()
	# $evil_wizard.evil_wizard_hit.connect(evil_wizard_hit)
	timer = $Timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_death_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		# print("do death animation")
		body.die()
		timer.start(1.5)

func _on_timer_timeout():
	get_tree().reload_current_scene()



func _on_game_pause_timer_timeout() -> void:
	# Unpause the game
	self.process_mode = Node.PROCESS_MODE_INHERIT

func short_pause(time: float) -> void:
	self.process_mode = Node.PROCESS_MODE_DISABLED
	$game_pause_timer.start(time)
	
func evil_wizard_hit() -> void:
	short_pause(0.1)
