extends Area2D

var speed = 0
var direction = Vector2(1,1)
var damage = 0
var sprite
@onready var player = get_node("/root/world/player")

signal slash_collision

var timer = 0.5

func _ready():
	add_to_group("attacks")

func _process(delta):
	timer-=delta
	if(timer<= 0):
		queue_free()

func initialize(direction_vector, initial_speed, initial_damage):
	if(direction_vector != Vector2.ZERO):
		direction = direction_vector.normalized()
	speed = initial_speed
	damage = initial_damage
	rotation = direction.angle()



func _on_body_entered(body):
	body.death(damage)
