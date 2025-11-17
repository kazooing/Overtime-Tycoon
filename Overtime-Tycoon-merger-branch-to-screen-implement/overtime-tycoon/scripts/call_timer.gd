extends TextureProgressBar

signal reduce_sanity(amount: float)
signal on_call(confirm: bool, object: Node2D)

@onready var reduce_cycle = get_node("sanity_reduction")
var timer: Timer
var start: bool = false

func _process(_delta: float) -> void:
	if start:
		visible = true
		value = timer.time_left
	else:
		visible = false

func _on_telephone_call_started(t: Timer) -> void:
	timer = t
	timer.timeout.connect(call_finished)
	start = true
	max_value = timer.wait_time
	reduce_cycle.start()
	print(timer.is_stopped())
	on_call.emit(true, self)

func call_finished() -> void:
	timer.stop()
	timer.timeout.disconnect(call_finished)
	start = false
	reduce_cycle.stop()
	on_call.emit(false, self)

func _on_sanity_reduction_timeout() -> void:
	reduce_sanity.emit(5)
