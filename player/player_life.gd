extends ProgressBar

func _ready():
	var group_members = get_tree().get_nodes_in_group("player")
	for emitter in group_members:
		emitter.connect("player_damage", life_depleted)
		
func life_depleted(damage_value):
	value -= damage_value
