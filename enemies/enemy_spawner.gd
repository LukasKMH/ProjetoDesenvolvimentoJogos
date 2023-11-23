# Para a geração dos inimigos foi usado este video como base: https://www.youtube.com/watch?v=xTMM8HLFy-A
extends Node

var rand = RandomNumberGenerator.new()
var enemyscene = load("res://enemies/enemy_phase_1.tscn")
@onready var screen_size = get_viewport().get_visible_rect().size

func _ready():
	for i in range (0,5):
		add_enemy()
	Events.enemy_died.connect(_on_enemy_died)

func add_enemy():
	var enemy = enemyscene.instantiate()
	rand.randomize()
	var x = rand.randf_range(0, screen_size.x)
	rand.randomize()
	var y = rand.randf_range(0, screen_size.y)
	enemy.position.x = x
	enemy.position.y = y
	add_child(enemy)

func _on_enemy_died():
	add_enemy()
