extends CharacterBody2D
class_name Enemy

@export var speed = 25.0
@onready var player = get_tree().get_first_node_in_group("player")
@onready var collision = $collision

var dead = false

func _physics_process(_delta):
	if dead:
		return
	
	#Calcula a direção para o jogador
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func die():
	Events.emit_signal("enemy_died")
	self.queue_free()

func _on_hit_body_entered(body):
	if body is Player:
		player.kill()
