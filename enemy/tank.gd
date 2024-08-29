extends CharacterBody2D

@onready var player = get_node("/root/world/player")
var speed = 50
var life = 40
var damage = 20
var exp_value = 30
var exp = load("res://items/exp.tscn")

func _physics_process(delta):
	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if(collision.get_collider().name == "player"):
			collision.get_collider().damage(damage)
			position -= direction 
			
func death(life_depleted):
	print("dano")
	life-=life_depleted
	if(life<=0):
		var exp_instance = exp.instantiate()
		exp_instance.global_position = position
		exp_instance.initialize(exp_value)
		get_parent().add_child(exp_instance)
		queue_free()
