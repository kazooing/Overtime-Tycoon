extends AnimatedSprite2D

@onready var tick = $clock_tick
var rng = RandomNumberGenerator.new()

func advance_time(amount: int = 1):
	frame += amount
	tick.pitch_scale = 1
	tick.pitch_scale += rng.randf_range(-0.05, 0.05)
	tick.play()
