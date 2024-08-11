extends Node2D



func _on_try_again_pressed():
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://interface/menu.tscn")
