extends Node2D


func _on_min_2_pressed():
	Global.set_minutes(2)

func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://interface/main_menu.tscn")

func _on_min_5_pressed():
	Global.set_minutes(5)

func _on_min_10_pressed():
	Global.set_minutes(10)
