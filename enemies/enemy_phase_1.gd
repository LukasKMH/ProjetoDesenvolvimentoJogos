extends CharacterBody2D
class_name Enemy

@export var speed = 25.0
@onready var player = get_tree().get_first_node_in_group("player")

var dead = false

func _physics_process(_delta):
	if dead:
		return
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func die():
	Events.emit_signal("enemy_died")
	self.queue_free()

