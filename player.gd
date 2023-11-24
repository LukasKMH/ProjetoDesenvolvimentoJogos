extends CharacterBody2D
class_name Player

@export var speed = 30.0

@onready var sprite:= $sprite
@onready var timer:= $Timer
@onready var aim:= $aim

const BULLET = preload("res://bullet.tscn") 

var dead = false

func _ready():
	sprite.play()
	timer.start()

func _physics_process(delta):
	if dead:
		return
	
	walk()
	aim.look_at(get_global_mouse_position())
	move_and_slide()

func walk():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	change_sprite_direction(direction)

func change_sprite_direction(direction):
	if direction.x < 0:
		sprite.scale.x = -1
	elif direction.x > 0:
		sprite.scale.x = 1

func shoot():
	if dead:
		return
	
	var bullet = BULLET.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $aim/position.global_position
	bullet.direction = (get_global_mouse_position() - bullet.position).normalized()

func _on_timer_timeout():
	shoot()

func kill():
	if dead:
		return
	dead = true
	get_tree().reload_current_scene()

func _on_area_2d_body_entered(body):
	if body is Enemy:
		self.kill()
