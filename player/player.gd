extends CharacterBody2D

var speed = 150

func _physics_process(delta):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	#verifica movimento
	if (input[0] != 0 or input[1] != 0):
		pass
	
	velocity = input * speed
	
	move_and_slide()
