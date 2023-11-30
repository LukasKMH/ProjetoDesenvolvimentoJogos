extends CharacterBody2D
class_name Player

@onready var sprite := $sprite
@onready var shoot_timer := $ShootTimer
@onready var get_damage_timer := $GetDamageTimer
@onready var aim := $aim
@onready var light_node := $PointLight2D

var is_interacting = false
var dead = false

var speed = 100.0
var life = 3
var wepon = Wepon.new(1, 1, 200) # Damage, time_to_shoot, bullet_velocity

func _ready():
	shoot_timer.wait_time = wepon.shootVelocity
	
	sprite.play()
	#check_and_execute_scenario_action()

func _physics_process(delta):
	if dead or is_interacting:
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
	
	var bulletSpawnPosition = $aim/position.global_position
	var bullet = wepon.shoot(bulletSpawnPosition,get_global_mouse_position())
	get_parent().add_child(bullet)

func _on_timer_timeout():
	shoot()

func get_damage(damage):
	if dead:
		return
	life -= damage
	sprite.modulate = Color(1, 0, 0)
	get_damage_timer.start()
	Events.emit_signal("playerDamaged")
	
	if life <= 0:
		dead = true
		get_tree().reload_current_scene()

func _on_area_2d_body_entered(body):
	if body is Enemy:
		self.get_damage(body.damage)
		body.knockback(self.velocity)

func _on_get_damage_timer_timeout():
	sprite.modulate = Color(1, 1, 1)
	
func check_and_execute_scenario_action():
	var current_scenario = get_tree().current_scene.get_name()
	if current_scenario.find("world_day") != -1:
		day_action()
	else:
		night_action()

func day_action():
	light_node.visible = false
	shoot_timer.stop()

func night_action():
	light_node.visible = true
	shoot_timer.start() 
