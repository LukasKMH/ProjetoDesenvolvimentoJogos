extends Node2D

var world1Load = preload("res://world/world1.tscn")

var world1

func _ready():
	loadWorld()

func loadWorld():
	world1 = world1Load.instantiate()
	add_child(world1)

func removeWorld():
	world1.queue_free()
