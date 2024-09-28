extends CharacterBody2D


@onready var health_bar = $health_bar
@onready var sprite : AnimatedSprite2D = $sprite
@onready var death_hit_boxes : Node2D = $death_hit_boxes

signal evil_wizard_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar.visible = false
	set_all_death_boxes_to_unmonitoring()

func _process(delta):
	pass

func attack1():
	sprite.play("Attack1")

func attack2():
	sprite.play("Attack2")



func take_hit():
	health_bar.visible = true
	health_bar.take_hit()
	sprite.play("Take_hit")
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_blink_intensity, 1.0, 0.0, 0.5)
	$timer_hide_health_bar.start(3.0)
	# emit_signal("evil_wizard_hit")
	get_node("/root/scene_02").short_pause(0.1)

func set_shader_blink_intensity(newValue : float):
	sprite.material.set_shader_parameter("blink_intensity", newValue)


func _on_sprite_animation_finished():
	if $health_bar.life == 0 and sprite.animation == "Take_hit":
		sprite.play("Death")
		$Area2D.set_deferred("monitoring", false)
		$CollisionShape2D.set_deferred("disabled", true)
	if sprite.animation == "Take_hit":
		sprite.play("Idle")
	elif sprite.animation == "Attack1":
		unmonitor_death_frame(get_node("death_hit_boxes/death_hit_box_attack_1_frame_7"))
		sprite.play("Idle")
	elif sprite.animation == "Attack2":
		unmonitor_death_frame(get_node("death_hit_boxes/death_hit_box_attack_2_frame_7"))
		sprite.play("Idle")



func _on_area_2d_body_entered(body):
	if GlobalVariables.is_player(body):
		if body.current_state != body.state.shell:
			$Area2D.set_deferred("monitoring", false)
			body.velocity.y = -250
			take_hit()


func _on_timer_hide_health_bar_timeout():
	health_bar.visible = false
	if $health_bar.life != 0:
		$Area2D.set_deferred("monitoring", true)
		pass


func _on_sprite_frame_changed():
	if sprite == null:
		return
	elif sprite.animation == "Attack1":
		if sprite.frame == 3:
			monitor_death_frame(get_node("death_hit_boxes/death_hit_box_attack_1_frame_" + str(sprite.frame)))
		elif sprite.frame >= 4:
			unmonitor_death_frame(get_node("death_hit_boxes/death_hit_box_attack_1_frame_" + str(sprite.frame - 1)))
			monitor_death_frame(get_node("death_hit_boxes/death_hit_box_attack_1_frame_" + str(sprite.frame)))
	elif sprite.animation == "Attack2":
		if sprite.frame == 4:
			monitor_death_frame(get_node("death_hit_boxes/death_hit_box_attack_2_frame_" + str(sprite.frame)))
		elif sprite.frame >= 5:
			unmonitor_death_frame(get_node("death_hit_boxes/death_hit_box_attack_2_frame_" + str(sprite.frame - 1)))
			monitor_death_frame(get_node("death_hit_boxes/death_hit_box_attack_2_frame_" + str(sprite.frame)))

# Probably not going to use this function
func clear_death_boxes():
	for child in death_hit_boxes.get_children():
		child.queue_free()

func set_all_death_boxes_to_unmonitoring():
	for frame in death_hit_boxes.get_children():
		unmonitor_death_frame(frame)

func unmonitor_death_frame(node : Node2D):
	for death_box in node.get_children():
		death_box.set_deferred("monitoring", false)
		death_box.visible = false

func monitor_death_frame(node : Node2D):
	for death_box in node.get_children():
		death_box.set_deferred("monitoring", true)
		death_box.visible = true
