extends Area2D

var speed = 500
var direction = Vector2(1,1)

var sprite
@onready var player = get_node("/root/world/player")

signal slash_collision

func _ready():
	sprite = $Sprite2D
	add_to_group("attacks")

func _process(delta):
	position += direction * speed * delta

func initialize(direction_vector, initial_speed):
	if(direction_vector != Vector2.ZERO):
		direction = direction_vector.normalized()
	speed = initial_speed
	rotation = direction.angle()
	


func _on_body_entered(body):
	emit_signal("slash_collision")
	queue_free()
