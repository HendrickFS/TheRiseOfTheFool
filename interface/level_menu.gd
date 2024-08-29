extends Node2D

var level_completed = 0
@onready var level01 = $Button
@onready var level02 = $Button2
@onready var level03 = $Button3

func _ready():
	level_completed = Global.get_level_completed()
	if level_completed >= 1:
		level02.disabled = false
	if level_completed >= 2:
		level03.disabled = false

func _on_button_pressed():
	Global.set_level_selected(1)
	get_tree().change_scene_to_file("res://world/world.tscn")

func _on_button_2_pressed():
	Global.set_level_selected(2)
	get_tree().change_scene_to_file("res://world/world.tscn")

func _on_button_3_pressed():
	Global.set_level_selected(3)
	get_tree().change_scene_to_file("res://world/world.tscn")

func _on_button_4_pressed():
	get_tree().change_scene_to_file("res://interface/main_menu.tscn")
