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
	
