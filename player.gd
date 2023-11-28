extends CharacterBody2D
class_name Player

@onready var sprite := $sprite
@onready var shoot_timer := $ShootTimer
@onready var get_damage_timer := $GetDamageTimer
@onready var aim := $aim
@onready var light_enabled = false 
@onready var light_node := $PointLight2D
const BULLET = preload("res://bullet.tscn") 

@export var speed = 30.0
var life = 3
var dead = false

func _ready():
	sprite.play()  
	check_and_execute_scenario_action()

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
	Events.emit_signal("playerDamaged")
	
	if life <= 0:
		dead = true
		get_tree().reload_current_scene()

func _on_area_2d_body_entered(body):
	if body is Enemy:
		self.get_damage()
		body.knockback(self)

func _on_get_damage_timer_timeout():
	sprite.modulate = Color(1, 1, 1)  # Reset color
	
func check_and_execute_scenario_action():
	var light_node = $PointLight2D
	var current_scenario = get_tree().current_scene.get_name()
	if current_scenario.find("world_day") != -1:
		day_action()
	else:
		night_action()

func day_action():
	light_enabled = false
	light_node.visible = light_enabled
	shoot_timer.stop()

func night_action():
	light_enabled = true
	light_node.visible = light_enabled
	shoot_timer.start() 
	
