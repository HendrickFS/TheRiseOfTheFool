extends Control

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://interface/level_menu.tscn")


func _on_controles_pressed():
	get_tree().change_scene_to_file("res://interface/instructions.tscn")




func _on_sair_pressed():
	get_tree().quit()
