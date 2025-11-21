extends Node

# note: script is autoload (singleton) meaning you can access it in any scene
# how to access: GM.{variable_name}

var day = 1
var curMoney = 0		#total money right now
var curSanity = 100
var maxSanity = 100
var calls_done_per_scene = 0
var money_gained_per_scene = 0
var weekly_target = 50

var pajangan = [
	{
		"id": "#000",
		"price": 10,
		"owned": false,
		"posx": 700,
		"posy": 150
	},
	{
		"id": "#001",
		"price": 30,
		"owned": false,
		"posx": 850,
		"posy": 150
		
	},
	{
		"id": "#002",
		"price": 50,
		"owned": false,
		"posx": 1000,
		"posy": 150
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
var pajangan_0 = 0
var pajangan_1 = 0
var pajangan_2 = 0
var pajangan_exist_0 = 0
var pajangan_exist_1 = 0
var pajangan_exist_2 = 0

signal reset()
signal new()
signal continue_option()
signal game_loop()
signal ahhh()
signal work_quit()
