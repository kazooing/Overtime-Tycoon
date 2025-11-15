extends Node2D

signal call_started(timer: Timer)
signal call_stopped(result: float)
signal phone_ringing(confirm: bool, object: Node2D)
signal decrease_sanity(pain: int)

var ring_in_X_chance: int = 4
var ring_cycle: float = 3
var call_time_range = Vector2i(5, 8)

const call_reward = 5

func _ready() -> void:
	var pickup = $Area2D
	pickup.on_call.connect(calling)
	pickup.off_call.connect(call_stop)
	
	var tele1 = get_node("Area2D/Telephone")
	tele1.is_ringing.connect(ringing)
	
	#this is my attempt to fix the spagghetto
	#this thing changes the variables that need a lot of tweaking
	pickup.time_range = call_time_range
	
	tele1.in_X = ring_in_X_chance - 1
	tele1.get_node("ring_timer").wait_time = ring_cycle
	
	

func calling(time:Timer):
	call_started.emit(time)

func call_stop():
	call_stopped.emit(5)

func ringing(confirm):
	if confirm:
		$reduce_when_ring.start()
	else:
		$reduce_when_ring.stop()
	phone_ringing.emit(confirm, self)

func _on_reduce_when_ring_timeout() -> void:
	decrease_sanity.emit(2)
