extends Node2D

func _ready():
	$AnimationPlayer.play("intro")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://interface/main_menu.tscn")
