extends CPUParticles2D


func _on_finished():
	self.queue_free()
