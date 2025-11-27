extends Node

# note: script is autoload (singleton) meaning you can access it in any scene
# how to access: GM.{variable_name}

var day = 1
var curMoney = 50 #total money right now
var curSanity = 100
var maxSanity = 100
var calls_done_per_scene = 0
var spreadsheets_done_per_scene = 0
var meetings_done_per_scene = 0
var money_gained_per_scene = 0
var weekly_target = 50

var add_money_telephone = 5
var add_money_spreadsheet = 7
var add_money_meeting = 20

var pajangan = [
	{
		"id": "000",
		"owned": false,
		"recover_bonus": 0.3,
		"decrease_bonus": 0.05,
		"icon" : "res://sprites1/upgrade_shop/decor/mugmug.PNG"
	},
	{
		"id": "001",
		"owned": false,
		"recover_bonus": 0.5,
		"decrease_bonus": 0.075,
		"icon" : "res://sprites1/upgrade_shop/decor/plant.PNG"
	},
	{
		"id": "002",
		"owned": false,
		"recover_bonus": 0.8,
		"decrease_bonus": 0.1,
		"icon" : "res://sprites1/upgrade_shop/decor/yourmom.PNG"
	}
]

var tasks = [
	{
		"id" = "000",
		"nama" = "telephone",
		"icon" = "res://sprites1/upgrade_shop/phone.png",
		"upgrade_value" = [7, 9, 12, 15],
		"upgrade_cost" = [5, 10, 15, 20],
		"owned" = true,
		"index" = 0
	},
	{
		"id" = "001",
		"nama" = "spreadsheet",
		"icon" = "res://sprites1/upgrade_shop/excell.png",
		"upgrade_value" = [9, 12, 16, 21],
		"upgrade_cost" = [7, 13, 19, 25],
		"owned" = false,
		"index" = -1,
		"unlock_cost" = 15
	},
	{
		"id" = "002",
		"nama" = "meeting",
		"icon" = "res://sprites1/work_scene/webcam put on top of monitor.png",
		"upgrade_value" = [25, 30, 35, 40],
		"upgrade_cost" = [18, 22, 26, 30],
		"owned" = false,
		"index" = -1,
		"unlock_cost" = 25
	}
]

#Day System
var day_count = 0
var week_count = 1
var weekly_mult = 3
var max_value = 0

#Menu System
var game_start_count = 0
var pause_resume_count = 0
var main_menu_count = -1
var loop_count = 0 
var first_loop = 0
var restart = 0

@onready var window_size_x:=get_window().size.x
@onready var window_size_y:=get_window().size.y

func _process(_delta: float) -> void:
	window_size_x = get_window().size.x
	window_size_y = get_window().size.y

signal reset()
signal new()
signal continue_option()
signal game_loop()
signal ahhh()
signal work_quit()
