extends Timer

signal division_passed()
var copy_prevention = false

func _process(_delta: float) -> void:
	if int(time_left) % 16 == 0 and not copy_prevention:
		print("timer passed segment   ", time_left)
		division_passed.emit()
		copy_prevention = true
	elif int(time_left) % 16 != 0:
		copy_prevention = false
