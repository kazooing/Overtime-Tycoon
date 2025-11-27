extends AnimatedSprite2D

signal finished(reward: float, pos: Vector2)
signal decrease(amount: float)
signal on_penalty(confirm:bool, object: Node)

var spreadsheet_completion:float = 0
@onready var progress = $TextureProgressBar
@onready var timer = $Penalty_timer
@onready var click_sfx = $click

func _on_spreadsheet_opener_closing_sheet() -> void:
	$Button.disabled = true


func _on_spreadsheet_opener_opening_sheet() -> void:
	$Button.disabled = false


func _on_button_button_down() -> void:
	spreadsheet_completion += 5
	if spreadsheet_completion >= 100:
		spreadsheet_completion = 0
		finished.emit(GM.add_money_spreadsheet, global_position)
		GM.spreadsheets_done_per_scene += 1
	progress.value = spreadsheet_completion
	click_sfx.play()
	penalty()

func penalty()-> void:
	decrease.emit(1)
	print(GM.curSanity)
	on_penalty.emit(true, self)
	timer.start()

func _on_penalty_timer_timeout() -> void:
	on_penalty.emit(false, self)
