extends CharacterBody2D

var speed = 150
var attack_direction = Vector2.ZERO

var slash_timer = 1
var slash = load("res://player/attacks/slash.tscn")

func _physics_process(delta):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#verifica movimento
	if (input[0] != 0 or input[1] != 0):
		attack_direction = input
		
	slash_timer-=delta
	if(slash_timer<=0):
		slash_timer = 1
		var slash_intance = slash.instantiate()
		add_child(slash_intance)
		slash_intance.initialize(Vector2(attack_direction), 300)
		
	
	velocity = input * speed
	
	move_and_slide()
