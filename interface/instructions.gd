extends Node2D


func _on_sair_pressed():
	get_tree().change_scene_to_file("res://interface/main_menu.tscn")
