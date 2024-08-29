extends Node2D

@onready var player = get_node("/root/world/player")

var chaser = load("res://enemy/chaser.tscn")
var tank = load("res://enemy/tank.tscn")
var enemies = [chaser, tank]
var rng = RandomNumberGenerator.new()

var timer = 5
func _process(delta):
	timer-=delta
	if(timer<=0):
		timer = 5
		var choice = randi_range(0, enemies.size()-1)
		var enemy_spawned = enemies[choice].instantiate()
		enemy_spawned.global_position = random_position()
		add_child(enemy_spawned)
		
func random_position():
	var player_position = player.global_position
	var minimum_x = player_position.x - 600
	var maximum_x = player_position.x + 600
	var minimum_y = player_position.y - 400
	var maximum_y = player_position.y + 400
	
	var x = rng.randi_range(minimum_x, maximum_x)
	var y = 0
	if (x > (player_position.x - 556) and x < (player_position.x + 556)):
		var up_dowm = rng.randi_range(0,1)
		if(up_dowm == 0):
			y = player_position.y - 324
		else:
			y = player_position.y + 324
			
	var random = Vector2(x, y)
	return random
