extends CharacterBody2D

@export var speed = 30.0

@onready var sprite:= $sprite

func _ready():
	sprite.play()

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	change_sprite_direction(direction)
	
	move_and_slide()

func change_sprite_direction(direction):
	if direction.x < 0:
		sprite.scale.x = -1
	elif direction.x > 0:
		sprite.scale.x = 1
