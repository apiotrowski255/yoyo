extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer.visible = false
	

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("option_menu"):
		if in_gameplay():
			if $CanvasLayer.visible == false:
				print("present options menu")
				$CanvasLayer.visible = true
				get_parent().get_child(3).process_mode = Node.PROCESS_MODE_DISABLED
			elif $CanvasLayer.visible == true:
				print("hide options menu - resume gameplay")
				$CanvasLayer.visible = false
				get_parent().get_child(3).process_mode = Node.PROCESS_MODE_INHERIT


func in_gameplay() -> bool:
	if get_parent().get_child(3).name.contains("scene") and not get_parent().get_child(3).name.contains("cutscene"):
		return true
	return false
