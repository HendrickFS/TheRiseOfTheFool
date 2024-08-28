extends Control

@onready var bt01 = $upgrades_container/HBoxContainer/upgrade01
@onready var bt02 = $upgrades_container/HBoxContainer2/upgrade02
@onready var bt03 = $upgrades_container/HBoxContainer3/upgrade03
var buttons = [bt01, bt02, bt03]
@onready var name1 = $upgrades_container/HBoxContainer/VBoxContainer/Label
@onready var name2 = $upgrades_container/HBoxContainer2/VBoxContainer/Label
@onready var name3 = $upgrades_container/HBoxContainer3/VBoxContainer/Label
var names = [name1, name2, name3]
@onready var desc1 = $upgrades_container/HBoxContainer/VBoxContainer/Label2
@onready var desc2 = $upgrades_container/HBoxContainer2/VBoxContainer/Label2
@onready var desc3 = $upgrades_container/HBoxContainer3/VBoxContainer/Label2
var descriptions = [desc1, desc2, desc3]

var speed_up = {
	"label": "Velocidade",
	"text": "Aumenta sua velocidade de 
	movimentação",
	"signal": "speed_up_signal"
}
signal speed_up_signal
var atackspeed_up = {
	"label": "Velocidade de ataque",
	"text": "Aumenta sua velocidade de 
	ataque",
	"signal": "attackspeed_up_signal"
}
signal attackspeed_up_signal
var life_recover = {
	"label": "Recuperação de vida",
	"text": "Recupere parte de sua
	vida",
	"signal": "life_recover_signal"
}
signal life_recover_signal
var life_increase = {
	"label": "Aumento de vida",
	"text": "Aumenta sua vida
	máxima",
	"signal": "life_increase_signal"
}
signal life_increase_signal
var experience_boost = {
	"label": "Ganho de EXP",
	"text": "Aumenta seu ganho de
	experiência",
	"signal": "experience_boost_signal"
}
signal experience_boost_signal
var aerial_slash = {
	"label": "Ataque aéreo",
	"text": "Ganhe um novo ataque",
	"signal": "aerial_slash_signal"
}
signal aerial_slash_signal

var power_ups = [speed_up, atackspeed_up, life_recover, life_increase, experience_boost, aerial_slash]
var power_ups_count = 6
var level_power_ups = []

var rng = RandomNumberGenerator.new()

func _ready():
	hide()
	var group_members = get_tree().get_nodes_in_group("player")
	for emitter in group_members:
		emitter.connect("player_level_up", on_level_up)
		
func on_level_up(required_exp):
	var power_up_01 = power_ups[rng.randi_range(0,power_ups_count-1)]
	var power_up_02 = power_ups[rng.randi_range(0,power_ups_count-1)]
	var power_up_03 = power_ups[rng.randi_range(0,power_ups_count-1)]
	level_power_ups = [power_up_01, power_up_02, power_up_03]
	name1.text = level_power_ups[0]["label"]
	desc1.text = level_power_ups[0]["text"]
	name2.text = level_power_ups[1]["label"]
	desc2.text = level_power_ups[1]["text"]
	name3.text = level_power_ups[2]["label"]
	desc3.text = level_power_ups[2]["text"]
	show()
	get_tree().paused = true


func _on_upgrade_01_pressed():
	hide()
	get_tree().paused = false
	emit_signal(level_power_ups[0]["signal"])
	if level_power_ups[0]["signal"] == "aerial_slash_signal":
		power_ups.remove(level_power_ups[0])
		power_ups_count -= 1

func _on_upgrade_02_pressed():
	hide()
	get_tree().paused = false
	emit_signal(level_power_ups[1]["signal"])
	if level_power_ups[0]["signal"] == "aerial_slash_signal":
		power_ups.remove(level_power_ups[0])
		power_ups_count -= 1

func _on_upgrade_03_pressed():
	hide()
	get_tree().paused = false
	emit_signal(level_power_ups[2]["signal"])
	if level_power_ups[0]["signal"] == "aerial_slash_signal":
		power_ups.remove(level_power_ups[0])
		power_ups_count -= 1
