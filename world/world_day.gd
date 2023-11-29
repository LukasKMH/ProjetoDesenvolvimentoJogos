extends Node2D

@onready var timer := $TimerDay
@onready var player = get_tree().get_first_node_in_group("player")
const MageShopMenu = preload("res://UI/mage_shop_gui.tscn") 
var time_left

func _ready():
	Events.playerInteractMage.connect(_on_player_interact_mage)
	Events.close_shop.connect(_on_mage_close_shop)

func _on_player_interact_mage():
	time_left = timer.time_left
	timer.stop()
	
	var mage_shop_menu = MageShopMenu.instantiate()
	mage_shop_menu.position = player.position
	self.add_child(mage_shop_menu)

func _on_mage_close_shop():
	timer.start(time_left)

func _on_timer_day_timeout():
	print("ACABOU O TEMPO")
