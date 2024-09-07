extends Node2D

@onready var background = $background
var bg01 = "res://world/assets/Cenario1.png"
var bg02 = "res://world/assets/Cenario2.png"
var bg03 = "res://world/assets/Cenario3.png"
var backgrounds = [bg01, bg02, bg03]
var level_selected = 0

func _ready():
	level_selected = Global.get_level_selected()
	print(level_selected)
	background.texture = load(backgrounds[level_selected-1])
	if(level_selected==1):
		$bg_music_lvl_1.play()
	elif(level_selected==2):
		$bg_music_lvl_2.play()
	elif(level_selected==3):
		$bg_music_lvl_3.play()
