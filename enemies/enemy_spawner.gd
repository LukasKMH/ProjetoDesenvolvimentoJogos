# Para a geração dos inimigos foi usado este video como base: https://www.youtube.com/watch?v=xTMM8HLFy-A
extends Node

func _ready():
	var rand = RandomNumberGenerator.new()
	var enemyscene = load("res://enemies/enemy_phase_1.tscn")
	
	var screen_size = get_viewport().get_visible_rect().size
	
	for i in range (0,5):
		var enemy = enemyscene.instantiate()
		rand.randomize()
		var x = rand.randf_range(0, screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0, screen_size.y)
		enemy.position.x = x
		enemy.position.y = y
		add_child(enemy)
	
