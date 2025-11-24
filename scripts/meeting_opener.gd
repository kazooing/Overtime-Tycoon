extends Sprite2D

signal opening_meeting()
signal closing_meeting()

@onready var anim_player = $AnimationPlayer
var is_open = false

func _on_button_button_down() -> void:
	if not is_open:
		is_open = true
		anim_player.play("Open and close meeting")
		opening_meeting.emit()
	else:
		is_open = false
		anim_player.play_backwards("Open and close meeting")
		closing_meeting.emit()

func disable():
	$Button.disabled = true
