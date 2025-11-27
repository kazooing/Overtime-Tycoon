extends Sprite2D

signal opening_sheet()
signal closing_sheet()
signal close_programs(exception: Node)

@onready var anim_player = $AnimationPlayer
var is_open = false

func _on_button_button_down() -> void:
	if not is_open:
		is_open = true
		anim_player.play("Open and close spreadsheet")
		close_programs.emit(self)
		opening_sheet.emit()
	else:
		is_open = false
		anim_player.play_backwards("Open and close spreadsheet")
		closing_sheet.emit()

func disable():
	$Button.disabled = true

func force_close(exception: Node):
	if exception == self or not is_open:
		return
	is_open = false
	anim_player.play_backwards("Open and close spreadsheet")
	closing_sheet.emit()
