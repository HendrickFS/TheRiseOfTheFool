extends Area2D

var exp_value = 0

signal exp_obtained(exp_value)

func initialize(value):
	exp_value = value

func _on_body_entered(body):
	emit_signal("exp_obtained", exp_value)
	queue_free()
