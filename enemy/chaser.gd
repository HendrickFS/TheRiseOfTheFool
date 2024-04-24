extends CharacterBody2D

@onready var player = get_node("/root/world/player")
var speed = 100

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * speed
	
	move_and_slide()
