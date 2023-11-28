extends Node2D

@onready var timer := $TimerDay
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_timer_day_timeout():
	print("ACBOU O TEMPO")
