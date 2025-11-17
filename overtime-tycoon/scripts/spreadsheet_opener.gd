extends Sprite2D

signal opening_sheet()
signal closing_sheet()

@onready var anim_player = $AnimationPlayer
var is_open = false

func _on_button_button_down() -> void:
	if not is_open:
		is_open = true
		anim_player.play("Open and close spreadsheet")
		opening_sheet.emit()
	else:
		is_open = false
		anim_player.play_backwards("Open and close spreadsheet")
		closing_sheet.emit()
