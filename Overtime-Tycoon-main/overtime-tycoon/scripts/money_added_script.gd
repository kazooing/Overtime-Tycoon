extends Label

var clock = 0




func _process(delta: float) -> void:
	if clock<1.2:
		clock+=delta
		position.y -= 0.5
		modulate.a -= delta/1.2
	if clock==1:
		queue_free()
