extends Node2D

signal call_started(timer: Timer)
signal call_stopped
signal phone_ringing(confirm: bool)

func _ready() -> void:
	var pickup = $Area2D
	pickup.on_call.connect(calling)
	pickup.off_call.connect(call_stop)
	
	var tele1 = get_node("Area2D/Telephone")
	tele1.is_ringing.connect(ringing)

func calling(time):
	call_started.emit(time)

func call_stop():
	call_stopped.emit()

func ringing(confirm):
	phone_ringing.emit(confirm)
