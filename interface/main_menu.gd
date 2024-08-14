extends Control

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_controles_pressed():
	pass # Replace with function body.


func _on_opções_pressed():
	pass # Replace with function body.


func _on_sair_pressed():
	get_tree().quit()
