extends Area2D

var speed = 500
var direction = Vector2(1,1)
var damage = 0
var sprite
@onready var player = get_node("/root/world/player")


func _ready():
	sprite = $Sprite2D
	add_to_group("enemy_attacks")

func _process(delta):
	position += direction * speed * delta

func initialize(direction_vector, initial_speed, initial_damage):
	if(direction_vector != Vector2.ZERO):
		direction = direction_vector.normalized()
	speed = initial_speed
	damage = initial_damage
	rotation = direction.angle()
	




func _on_body_entered(body):
	body.damage(damage)
	queue_free()
