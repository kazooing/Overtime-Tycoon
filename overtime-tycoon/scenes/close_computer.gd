extends Sprite2D

@onready var anim = $AnimationPlayer

func _ready():
	await get_tree().create_timer(1.0).timeout
	anim.play("open")

func turn_off():
	anim.play("close")

func turn_on():
	anim.play("open")
