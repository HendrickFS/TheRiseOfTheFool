extends CharacterBody2D

@onready var player = get_node("/root/world/player")
var speed = 30
var life = 15
var damage = 10
var exp_value = 15
var exp = load("res://items/exp.tscn")
#@onready var _animated_sprite: AnimatedSprite2D = $Sprite2D

var attack = load("res://enemy/enemy_slash.tscn")
var attack_timer = 1.5
var attack_cooldown = 1.5
var attack_damage = 10

@onready var sprite = $Sprite2D
var assets = [
	"res://enemy/assets/Saci.png",
	"res://enemy/assets/Iara.png",
	"res://enemy/assets/Saci.png"
]

func _ready():
	var group_members = get_tree().get_nodes_in_group("attacks")
	var level_selected = Global.get_level_selected()
	# Use level_selected para saber qual sprite utilizar
	
func _physics_process(delta):
	attack_timer-=delta
	if(attack_timer<=0):
		attack_timer = attack_cooldown
		var attack_instance = attack.instantiate()
		add_child(attack_instance)
		attack_instance.initialize(global_position.direction_to(player.global_position), 100, attack_damage)


	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if(collision.get_collider().name == "player"):
			collision.get_collider().damage(damage)
			position -= direction 
	
	#_animate_chaser() 

#func _animate_chaser():
	#if(velocity.x > 0):
		#_animated_sprite.flip_h = false
		#_change_chaser()
	#else:
		#_animated_sprite.flip_h = true
		#_change_chaser()
		

#func _change_chaser():
	#var level = Global.get_level_selected()
	#if(level==1):
		#_animated_sprite.play("curupira_walk")
	#elif(level==2):
		#_animated_sprite.play("boto_walk")
	#elif(level==3):
		#_animated_sprite.play("boitata_walk")

func death(life_depleted):
	life-=life_depleted
	if(life<=0):
		var exp_instance = exp.instantiate()
		exp_instance.global_position = position
		exp_instance.initialize(exp_value)
		get_parent().add_child(exp_instance)
		queue_free()
	#else:
		#$AnimationPlayer.play("damage") # inimigo pisca vermelho quando toma dano
		#await get_tree().create_timer(0.6).timeout
		#$AnimationPlayer.play("normal")
