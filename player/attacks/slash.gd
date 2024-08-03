extends Area2D

var speed = 500
var direction = Vector2.ZERO
var sprite
@onready var player = get_node("/root/world/player")


func _ready():
	sprite = $Sprite2D

func _process(delta):
	position += direction * speed * delta

func initialize(direction_vector, initial_speed):
	direction = direction_vector.normalized()
	speed = initial_speed
	rotation = direction_vector.angle()
	
	
