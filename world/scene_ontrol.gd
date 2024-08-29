extends Control

@onready var timer_label = $timer_label
@onready var timer = $Timer

var minutes = 10
var seconds = 0

func _process(delta):
	timer_label.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)
	if(minutes==0 and seconds==0 ):
		if Global.get_level_selected() == 1:
			Global.set_level_completed(1)
		elif Global.get_level_selected() == 2:
			Global.set_level_completed(2)
		elif Global.get_level_selected() == 3:
			Global.set_level_completed(3)
		get_tree().change_scene_to_file("res://interface/game_win.tscn")

func _on_timer_timeout():
	if seconds == 0:
		minutes-=1
		seconds = 59
	else:
		seconds-=1
