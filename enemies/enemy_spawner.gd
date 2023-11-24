# Para a geração dos inimigos foi usado este video como base: https://www.youtube.com/watch?v=xTMM8HLFy-A
extends Node

var rand = RandomNumberGenerator.new()
var enemyscene = load("res://enemies/enemy_phase_1.tscn")

@onready var player = $Player

func _ready():
	for i in range (0,30):
		respawn_enemy()
	Events.enemy_died.connect(_on_enemy_died)

func respawn_enemy():
	var enemy = enemyscene.instantiate()
	rand.randomize()
	var x = rand.randf_range(32, 704)
	rand.randomize()
	var y = rand.randf_range(40, 416)
	
	while player.global_position.distance_to(Vector2(x, y)) < 100.0:
		rand.randomize()
		x = rand.randf_range(32, 704)
		rand.randomize()
		y = rand.randf_range(40, 416)
	
	# TODO inimigo não deve dar respawn numa parede
	
	enemy.position.x = x
	enemy.position.y = y
	
	add_child(enemy)

func _on_enemy_died():
	respawn_enemy()
