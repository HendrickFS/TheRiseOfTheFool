extends CharacterBody2D

@onready var player = get_node("/root/world/player")
var speed = 100
var exp = load("res://items/exp.tscn")

func _physics_process(delta):
	var group_members = get_tree().get_nodes_in_group("attacks")
	for emitter in group_members:
		emitter.connect("slash_collision", on_slash_collision)
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * speed
	
	move_and_slide()

func on_slash_collision():
	var exp_instance = exp.instantiate()
	exp_instance.global_position = position
	get_parent().add_child(exp_instance)
	queue_free()
