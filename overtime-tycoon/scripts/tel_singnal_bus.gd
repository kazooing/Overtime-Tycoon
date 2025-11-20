extends Node2D

signal call_started(timer: Timer)
signal call_stopped(result: float)
signal phone_ringing(confirm: bool, object: Node2D)
signal decrease_sanity(pain: int)
signal call_notif(value: float, notif_pos : Vector2)
signal disable_telephone()
signal enable_telephone()

var ring_in_X_chance: int = 1
var ring_cycle: float = 3
var fail_limit: int = 4
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
	tele1.fail_limit = fail_limit
	
	

func calling(time:Timer):
	call_started.emit(time)

# call finished
func call_stop(): 
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

func disable() -> void:
	disable_telephone.emit()

func enable() -> void:
	enable_telephone.emit()
