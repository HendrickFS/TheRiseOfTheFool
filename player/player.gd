extends CharacterBody2D

var speed = 500

func _physics_process(delta):
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = input * speed
	
	move_and_slide()
