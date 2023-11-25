extends CharacterBody2D
class_name Player

@onready var sprite:= $sprite
@onready var shoot_timer:= $ShootTimer
@onready var get_damage_timer:= $GetDamageTimer
@onready var aim:= $aim

const BULLET = preload("res://bullet.tscn") 

@export var speed = 30.0
var life = 3
var dead = false

func _ready():
	sprite.play()
	shoot_timer.start()

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

func get_damage():
	if dead:
		return
	life -= 1
	sprite.modulate = Color(1, 0, 0)
	get_damage_timer.start()
	
	if life <= 0:
		dead = true
		get_tree().reload_current_scene()

var last_body_entered
func _on_area_2d_body_entered(body):
	if body is Enemy:
		last_body_entered = body
		self.get_damage()
		body.knockback(self)

func _on_get_damage_timer_timeout():
	sprite.modulate = Color(1, 1, 1) #reset color
