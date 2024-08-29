extends Node2D

@onready var background = $background
var level_selected = 0

func _ready():
	level_selected = Global.get_level_selected()
	print(level_selected)
