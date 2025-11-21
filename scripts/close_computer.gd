extends Sprite2D

@onready var anim = $AnimationPlayer

func _ready():
	anim.play("open")

func turn_off():
	anim.play("close")

func turn_on():
	anim.play("open")
