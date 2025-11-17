extends Node2D

signal is_ringing(confirm:bool)

@onready var b_cancel = get_node("Cancel Button")
@onready var sprite = get_node("Area2D/Telephone Sprite")
@onready var timer = $ring_timer
@onready var rng = RandomNumberGenerator.new()

var in_X:int

var active = true
var ringing = false

func _ready() -> void:
	var pickup = get_parent()
	pickup.on_call.connect(calling)
	pickup.off_call.connect(hang_up)
	
	print("chances", in_X)
	print("timer", timer.wait_time)

func _process(_delta):
	if active:
		if timer.is_stopped() and not ringing:
			print("timer started")
			timer.start()
	if ringing:
		sprite.play("Ringing")
		sprite.rotation = deg_to_rad(90)
	else:
		sprite.play("Static")

func _on_timer_timeout() -> void:
	print("timer called")
	if rng.randi_range(0,in_X) == 0:
		ringing = true
		is_ringing.emit(true)
	timer.stop()


func _on_button_button_down() -> void:
	if ringing:
		ringing = false
		is_ringing.emit(false)

func calling(_X):
	timer.stop()
	active = false

func hang_up():
	active = true
