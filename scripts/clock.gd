extends AnimatedSprite2D

@onready var tick = $clock_tick

func advance_time(amount: int = 1):
	frame += amount
	tick.play()
