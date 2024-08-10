extends CharacterBody2D

@onready var player = get_node("/root/world/player")
var speed = 100
var exp = load("res://items/exp.tscn")
@onready var _animated_sprite: AnimatedSprite2D = $Sprite2D

func _physics_process(delta):
	var group_members = get_tree().get_nodes_in_group("attacks")
	for emitter in group_members:
		emitter.connect("slash_collision", on_slash_collision)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	
	move_and_slide()
	_animate_chaser() 

func _animate_chaser():	
	if(velocity.x > 0):
		_animated_sprite.flip_h = false
		_animated_sprite.play("curupira_walk")
	else:
		_animated_sprite.flip_h = true
		_animated_sprite.play("curupira_walk")

func death():
	var exp_instance = exp.instantiate()
	exp_instance.global_position = position
	get_parent().add_child(exp_instance)
	queue_free()
	
func on_slash_collision():
	pass
