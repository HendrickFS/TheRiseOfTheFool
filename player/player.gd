extends CharacterBody2D

var speed = 150
var attack_direction = Vector2.ZERO

var slash_flag = false
var slash_cooldown = 4
var slash_timer = 4
var slash_damage = 15
var slash = load("res://player/attacks/slash.tscn")
var slash_direction = [Vector2(0,-1),Vector2(1, -1), Vector2(1, 0), Vector2(1, 1), Vector2(0, 1), Vector2(-1, 1), Vector2(-1, 0), Vector2(-1, -1)]

var attack = load("res://player/attacks/attack.tscn")
var attack_timer = 1
var attack_cooldown = 1
var attack_damage = 20

var damage_timer = 1
var damage_flag = true
signal player_damage(value)
signal player_heal(life_value)
signal life_increase(new_life)

var max_life = 100
var life = 100

var experience = 0
var experience_multiplier = 1

var level = 0
var required_level = 100 * (1.5)**level #100 é o custo base para passar nivel, a cada nivel o custo do nivel anterior ira ser multiplicado por 1.5

signal experience_obtained(exp_value)
signal player_level_up(new_exp_required)

@onready var _animated_sprite: AnimatedSprite2D = $Sprite2D
@onready var levelup_control = $Camera2D/Control/levelup_control

func _ready():
	if (levelup_control != null):
		levelup_control.connect("speed_up_signal", on_speed_up)
		levelup_control.connect("attackspeed_up_signal", on_attackspeed_up)
		levelup_control.connect("life_recover_signal", on_life_recover)
		levelup_control.connect("life_increase_signal", on_life_increase)
		levelup_control.connect("experience_boost_signal", on_experience_boost)
		levelup_control.connect("aerial_slash_signal", on_aerial_slash)

func _physics_process(delta):
	var input = Input.get_vector("left", "right", "up", "down")
	#verifica movimento
	if (input[0] != 0 or input[1] != 0):
		attack_direction = input

	attack_timer-=delta
	if(attack_timer<=0):
		attack_timer = attack_cooldown
		var attack_instance = attack.instantiate()
		add_child(attack_instance)
		attack_instance.initialize(attack_direction, 0, attack_damage)

	slash_timer-=delta
	if(slash_timer<=0):
		slash_timer = slash_cooldown
		if(slash_flag):
			for i in range(slash_direction.size()):
				var slash_intance = slash.instantiate()
				add_child(slash_intance)
				slash_intance.initialize(Vector2(slash_direction[i-1]), 300, slash_damage)
		
	if damage_flag:
		damage_timer-=delta
		if(damage_timer<=0):
			damage_flag = false
			
	var group_members = get_tree().get_nodes_in_group("experience")
	for emitter in group_members:
		emitter.connect("exp_obtained", get_experience)
		
	
	velocity = input * speed
	
	move_and_slide()
	_animate_player() #falta o ataque


func _animate_player():
	if life <= 0:
		_animated_sprite.play("player_dies")
	else:	
		if velocity.x == 0:
			if (velocity.y >= 0):
				_animated_sprite.play("player_walk")
			else:
				_animated_sprite.play("player_walk_back")
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
		emit_signal("player_damage", damage_value)
		if(life <= 0):
			gameover()
		
func gameover():
	await get_tree().create_timer(0.1).timeout
	set_physics_process(false)
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://interface/game_over.tscn")

func get_experience(exp_value):
	experience+=exp_value * experience_multiplier
	emit_signal("experience_obtained", experience)
	if(experience >= required_level):
		level += 1
		experience = 0
		required_level = 100 * (1.5)**level
		level_up()
	
func level_up():
	emit_signal("player_level_up", required_level)
	
func on_speed_up():
	speed+=50
	
func on_attackspeed_up():
	if(attack_cooldown>0.3):
		attack_cooldown-=0.1

func on_life_recover():
	life+=30
	if life > max_life:
		life = max_life
	emit_signal("player_heal", life)

func on_life_increase():
	max_life+=30
	life+=30
	emit_signal("life_increase", max_life)
	emit_signal("player_heal", life)

func on_experience_boost():
	experience_multiplier+=0.5

func on_aerial_slash():
	slash_flag = true
