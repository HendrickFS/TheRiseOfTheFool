extends ProgressBar

func _process(delta):
	var group_members = get_tree().get_nodes_in_group("player")
	for emitter in group_members:
		emitter.connect("experience_obtained", experience_increase)
		emitter.connect("player_level_up", level_up)
		
func experience_increase(exp_value):
	value = exp_value

func level_up(new_exp_required):
	max_value = new_exp_required
	value = 0
