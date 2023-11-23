extends CharacterBody2D

@export var speed = 25.0
@onready var player = get_tree().get_first_node_in_group("player")


func _physics_process(_delta):
	#Calcula a direção para o jogador
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
