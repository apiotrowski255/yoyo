extends Node2D

@onready var lighting = $lighting
@onready var warning = $warning
@onready var death_hit_box = $death_hit_box

@export var sound_volume_adjust = 0.0
@export var self_delete_when_finished = true


# Called when the node enters the scene tree for the first time.
func _ready():
	$warning_sound_effect.volume_db = sound_volume_adjust
	$thunder_sound_effect.volume_db = sound_volume_adjust
	death_hit_box.disable()


func set_volume(new_volume):
	$warning_sound_effect.volume_db = new_volume
	$thunder_sound_effect.volume_db = new_volume

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
	if self_delete_when_finished == true:
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


func deactivate():
	self.process_mode = Node.PROCESS_MODE_DISABLED
	self.visible = false
	
func activate():
	self.process_mode = Node.PROCESS_MODE_INHERIT
	self.visible = true
