extends CharacterBody2D

@onready var player = get_node("/root/world/player")
var speed = 50
var life = 40
var damage = 20
var exp_value = 30
var exp = load("res://items/exp.tscn")
@onready var _animated_sprite: AnimatedSprite2D = $Sprite2D

var assets = [
	"res://enemy/assets/mulaSemCabeca.png",
	"res://enemy/assets/Cuca.png",
	"res://enemy/assets/bicho_papao.png"
]

func _physics_process(delta):
	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if(collision.get_collider().name == "player"):
			collision.get_collider().damage(damage)
			position -= direction 
			
	_animate_tank() 

func _animate_tank():
	if(velocity.x > 0):
		_animated_sprite.flip_h = false
		_change_tank()
	else:
		_animated_sprite.flip_h = true
		_change_tank()
		
func _change_tank():
	var level = Global.get_level_selected()
	if(level==1):
		_animated_sprite.play("mula_walk")
	elif(level==2):
		_animated_sprite.play("cuca_walk")
	elif(level==3):
		_animated_sprite.play("bichopapao_walk")
			
func death(life_depleted):
	print("dano")
	life-=life_depleted
	if(life<=0):
		var exp_instance = exp.instantiate()
		exp_instance.global_position = position
		exp_instance.initialize(exp_value)
		get_parent().add_child(exp_instance)
		queue_free()
	else:
		$AnimationPlayer.play("damage") # inimigo pisca vermelho quando toma dano
		await get_tree().create_timer(0.6).timeout
		$AnimationPlayer.play("normal")
