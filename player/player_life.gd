extends ProgressBar

func _ready():
	var group_members = get_tree().get_nodes_in_group("player")
	for emitter in group_members:
		emitter.connect("player_damage", life_depleted)
		emitter.connect("player_heal", life_recover)
		emitter.connect("life_increase", life_increase)
		
func life_depleted(damage_value):
	value -= damage_value

func life_recover(life_value):
	value = life_value
		
func life_increase(life_value):
	max_value = life_value
