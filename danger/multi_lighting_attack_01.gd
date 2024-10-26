extends Node2D

var timer : Timer
var wait_time = 0.05

var current_array : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_node("Timer")
	for i in get_node("lighting_container").get_children():
		i.deactivate()
	phase_1()


func phase_1():
	current_array = get_node("lighting_container").get_children()
	timer.start(0.5)


func get_phase_1_attacks():
	var array : Array
	var i = 0
	while i < 12:
		array.append(get_node("lighting_container").get_child(i))
		i += 1
	return array

func _on_timer_timeout() -> void:
	if get_non_activate_lighting_attack_from_current_array() != null:
		get_non_activate_lighting_attack_from_current_array().activate()
	else:
		timer.stop()

		
func get_non_activate_lighting_attack_from_current_array():
	var i = 0
	while i < current_array.size():
		if current_array[i] != null and current_array[i].process_mode ==  Node.PROCESS_MODE_DISABLED:
			return current_array[i]
		i += 1
	return null

func deactivate_all_items_in_current_array():
	var i = 0
	while i < current_array.size():
		current_array[i].deactivate()
		i += 1
