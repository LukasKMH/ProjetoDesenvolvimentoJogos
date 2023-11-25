extends HBoxContainer

@onready var HeartGUI = preload("res://interface/heart_gui.tscn")
@onready var player = get_tree().get_first_node_in_group("player")

var hearts = []

func _ready():
	setHearts()
	Events.playerDamaged.connect(removeHeart)

func setHearts():
	for i in range(0, player.life):
		var heart = HeartGUI.instantiate()
		hearts.append(heart)
		add_child(heart)

func removeHeart():
	if hearts.size() > 0:
		var heart = hearts.pop_back()
		heart.queue_free()
