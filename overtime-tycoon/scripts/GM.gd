extends Node

# note: script is autoload (singleton) meaning you can access it in any scene
# how to access: GM.{variable_name}

var curMoney = 0		#total money right now
var curSanity = 100
var maxSanity = 100
var calls_done_per_scene = 0
var money_gained_per_scene = 0
var weekly_target = 50
