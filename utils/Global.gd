extends Node

var level_selected = 0
# 0 -> Nenhuma fase
# 1 -> Primeira fase
# 2 -> Segunda fase
# 3 -> Terceira fase

var level_completed = 0
# 0 -> Nenhuma fase vencida
# 1 -> Primeira fase vencida
# 2 -> Segunda fase vencida
# 3 -> Terceira fase vencida

var minutes = 10

func _ready():
	print("Global loaded")

func get_level_selected():
	return level_selected

func set_level_selected(level):
	level_selected = level

func get_level_completed():
	return level_completed

func set_level_completed(level):
	level_completed = level
	print("Level completed: ", level_completed)
	
func get_minutes():
	return minutes

func set_minutes(option_minutes):
	minutes = option_minutes

