extends ProgressBar

var target_timer: Timer
var active = false
func _process(_delta: float) -> void:
	if active:
		visible = true
		value = target_timer.time_left
	else:
		visible = false

func _on_telephone_call_started(timer: Timer) -> void:
	target_timer = timer
	max_value = timer.time_left
	active = true
	target_timer.timeout.connect(_on_timeout)

func _on_timeout() -> void:
	active = false;
