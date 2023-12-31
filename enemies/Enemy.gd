extends CharacterBody2D
class_name Enemy

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $sprite
@onready var get_damage_timer:= $GetDamageTimer
@onready var blood_particles:= $BloodParticles
@onready var collision:= $collision

var direction = Vector2(0,0)
var dead = false

var speed
var damage
var life

func init(speed, damage, life):
	self.speed = speed
	self.damage = damage
	self.life = life

func _ready():
	blood_particles.emitting = false

func _physics_process(_delta):
	if dead:
		return
	direction = (player.global_position - self.global_position).normalized()
	change_sprite_direction()
	velocity = direction * speed
	move_and_slide()

func change_sprite_direction():
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false

func get_damage(damage):
	life -= damage
	sprite.modulate = Color(1, 0, 0)
	blood_particles.emitting = true
	get_damage_timer.start()
	
	if life <= 0:
		dead = true
		die()

func knockback(bodyVelocity): #Peguei a função nesse vídeo https://www.youtube.com/watch?v=SNWpFTer-YU&list=PLMQtM2GgbPEVuTgD4Ln17ombTg6EahSLr&index=17
	var knockback_power = 800
	var knockback_direction = (bodyVelocity - self.velocity).normalized() * knockback_power
	velocity = knockback_direction
	move_and_slide()

func die():
	Events.emit_signal("enemy_died")
	self.queue_free()

func _on_get_damage_timer_timeout():
	blood_particles.emitting = false
	sprite.modulate = Color(1, 1, 1) #reset color

func _on_area_2d_body_entered(body):
	self.respawn()

var rand = RandomNumberGenerator.new()
func respawn():
	rand.randomize()
	var x = rand.randf_range(32, 704)
	rand.randomize()
	var y = rand.randf_range(40, 416)
	
	while player.global_position.distance_to(Vector2(x, y)) < 85.0:
		rand.randomize()
		x = rand.randf_range(32, 704)
		rand.randomize()
		y = rand.randf_range(40, 416)
	
	self.position.x = x
	self.position.y = y
