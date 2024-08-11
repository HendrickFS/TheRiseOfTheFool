extends CharacterBody2D

var speed = 150
var attack_direction = Vector2.ZERO

var slash_timer = 1
var slash = load("res://player/attacks/slash.tscn")

var damage_timer = 1
var damage_flag = false

var life = 100
var experience = 0
var level = 0
var required_level = 100 * (1.5)**level #100 é o custo base para passar nivel, a cada nivel o custo do nivel anterior ira ser multiplicado por 1.5

@onready var _animated_sprite: AnimatedSprite2D = $Sprite2D

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
		
	if damage_flag:
		damage_timer-=delta
		if(damage_timer<=0):
			damage_flag = false
		
	
	velocity = input * speed
	
	move_and_slide()
	_animate_player() #falta o ataque


func _animate_player():
	if velocity.x == 0:
		_animated_sprite.play("player_walk")
	else:
		if(velocity.x > 0):
			_animated_sprite.flip_h = false
			_animated_sprite.play("player_walk_side")
		else:
			_animated_sprite.flip_h = true
			_animated_sprite.play("player_walk_side")
			
func damage(damage_value):
	if !damage_flag:
		life -= damage_value
		damage_flag = true
		damage_timer = 1
		if(life <= 0):
			gameover()
		
func gameover():
	get_tree().change_scene_to_file("res://interface/game_over.tscn")

