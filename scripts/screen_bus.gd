extends Sprite2D

signal gain_money(amount:float)
signal decrease_sanity(amount: float)
signal new_decreaser(confirm:bool, object: Node)
signal money_notification(amount:float, pos: Vector2)
signal disable

func call_decrease_sanity(amount: float):
	print("call_decrease_sanity ", amount)
	decrease_sanity.emit(amount)

func call_new_decreaser(confirm:bool, object: Node):
	new_decreaser.emit(confirm, object)

func call_gain_money(amount: float, spawn_pos: Vector2):
	gain_money.emit(amount)
	money_notification.emit(amount, spawn_pos)

func disable_computer():
	disable.emit()
