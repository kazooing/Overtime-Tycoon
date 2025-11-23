extends Node2D

signal call_started(code: int)
signal call_stopped(result: float)
signal restart_timer
signal phone_ringing(confirm: bool, object: Node2D)
signal decrease_sanity(pain: int)
signal call_notif(value: float, notif_pos : Vector2)
signal disable_telephone
signal enable_telephone

var ring_in_X_chance: int = 4
var ring_cycle: float = 3
var max_fails: int = 4

const call_reward = 5

func _ready() -> void:
	var pickup = $Area2D
	pickup.on_call.connect(calling)
	
	var tele1 = get_node("Area2D/Telephone")
	tele1.is_ringing.connect(ringing)
	
	#this is my attempt to fix the spagghetto
	#this thing changes the variables that need a lot of tweaking
	
	tele1.in_X = ring_in_X_chance - 1
	tele1.get_node("ring_timer").wait_time = ring_cycle
	tele1.max_fails = max_fails
	
	

func calling():
	print("SHOULD BE PRINTING OUT DIALOGUE")
	call_started.emit()

# call finished
func call_stop():
	restart_timer.emit() 
	call_stopped.emit(5) # add money
	call_notif.emit(5, $spawn_pos.global_position)
	GM.calls_done_per_scene += 1

func ringing(confirm):
	if confirm:
		$reduce_when_ring.start()
	else:
		$reduce_when_ring.stop()
	phone_ringing.emit(confirm, self)

func _on_reduce_when_ring_timeout() -> void:
	decrease_sanity.emit(2)

func disable():
	disable_telephone.emit()

func enable():
	enable_telephone.emit()
