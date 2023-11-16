extends CharacterBody2D

var direction: Vector2
var speed = 200

func _physics_process(delta):
	move_and_collide(direction * delta * speed)
