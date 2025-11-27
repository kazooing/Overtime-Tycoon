extends TextureButton


@export var task_name: String
@export var task_description: String
@export var task_to_use: String
@onready var UIlayer = get_node("/root/UpgradeShop/UILayer")
@onready var task_id = int(str(name))
@onready var task_status = GM.tasks[int(task_id)]["index"]
@onready var item_status = get_parent().get_node("item_status")
@onready var item_status_clicked = get_parent().get_node("item_status_clicked")
@onready var timer = get_parent().get_node("Timer")

func _ready() -> void:
	if task_status == -1:	#locked
		item_status.texture = load("res://sprites1/upgrade_shop/buy default.png")
		item_status_clicked.texture = load("res://sprites1/upgrade_shop/buy when click.png")
	elif task_status > -1 && task_status < 4: #upgrade
		item_status.texture = load("res://sprites1/upgrade_shop/upgrade default.png")
		item_status_clicked.texture = load("res://sprites1/upgrade_shop/upgrade when click.png")
	else:	#max upgrade
		item_status.texture = load("res://sprites1/upgrade_shop/upgrade when click.png")
		disabled = true
		
func _pressed() -> void:
	task_status = GM.tasks[int(task_id)]["index"]
	var final_task_desc = task_description + "\n\n" + task_to_use
	UIlayer.open_inspector_task(task_name, final_task_desc, task_id, task_status)
	item_status_clicked.visible = true
	timer.start()
	await get_tree().create_timer(1).timeout
	if GM.tasks[3]["owned"] == true:
		get_tree().change_scene_to_file("res://scenes/ending_scene_sad.tscn")


func _on_timer_timeout() -> void:
		item_status_clicked.visible = false
