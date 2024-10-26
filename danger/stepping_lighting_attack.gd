extends Node2D

var timer : Timer
@export var time_between_attacks = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_node("lighting_attack_container").get_children():
		i.set_volume(-9.0)
		i.deactivate()
	timer = get_node("Timer")
	timer.start(time_between_attacks)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if get_non_activate_lighting_attack() != null:
		get_non_activate_lighting_attack().activate()
		
	else:
		timer.stop()
		
func get_non_activate_lighting_attack():
	var i = 0
	while i < get_node("lighting_attack_container").get_child_count():
		if get_node("lighting_attack_container").get_child(i) != null and get_node("lighting_attack_container").get_child(i).process_mode ==  Node.PROCESS_MODE_DISABLED:
			return get_node("lighting_attack_container").get_child(i)
		i += 1
	return null
	
