extends Node2D

@onready var lighting = $lighting
@onready var warning = $warning
@onready var death_hit_box = $death_hit_box


# Called when the node enters the scene tree for the first time.
func _ready():
	death_hit_box.disable()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_warning():
	pass
	
func play_lighting():
	pass

func activate_hitbox():
	pass

func _on_lighting_animation_finished():
	death_hit_box.disable()
	self.queue_free()


func _on_lighting_frame_changed():
	if lighting.frame == 5:
		death_hit_box.enable()
	elif lighting.frame == 12:
		death_hit_box.disable()
	elif lighting.frame == 3:
		$thunder_sound_effect.play()



func _on_warning_animation_finished():
	warning.visible = false
	warning.stop()
	lighting.play("default")
