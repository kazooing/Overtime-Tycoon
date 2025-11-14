extends Area2D
signal on_call(timer: Timer)
signal off_call()
@onready var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var button = get_node("Telephone/Area2D/Button")
	button.button_down.connect(on_press)
	button.button_up.connect(on_release)

var overlapping_previous = false
func _process(_delta) -> void:
	if has_overlapping_areas() and not overlapping_previous:
		overlapping_previous = true
		print("yeay")
		var sex = get_overlapping_areas()[0].get_parent()
		if sex.ringing:
			sex.ringing = false;
			sex.is_ringing.emit(false)
			$Timer.start(rng.randi_range(5, 10))
			on_call.emit($Timer)
	elif not has_overlapping_areas():
		overlapping_previous = false

func on_press() -> void:
	$pickup_marker.visible = true

func on_release() -> void:
	$pickup_marker.visible = false

func _on_timer_timeout() -> void:
	off_call.emit()
	print("off call")
