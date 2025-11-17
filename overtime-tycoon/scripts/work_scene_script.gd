extends Node2D

var money_added_animation := preload("res://scenes/money_added.tscn")

func _ready() -> void:
	GM.calls_done_per_scene = 0
	GM.money_gained_per_scene = 0


func play_added_money(amount_added: int, spawn_pos: Vector2) -> void:
	spawn_add_money(spawn_pos, amount_added) 


func spawn_add_money(pos: Vector2 , added):
	var moneyAdded = money_added_animation.instantiate()
	moneyAdded.position = pos
	moneyAdded.text = "+ $ " + str(added)
	
	add_child(moneyAdded)


func _on_work_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/day_recap_scene.tscn")
