extends Control
class_name MageShop

var player

func _ready():
	player = self.get_parent().find_child("Player")
	player.is_interacting = true

func _on_button_buy_velocity_pressed():
	player.speed += 20

func _on_button_buy_life_pressed():
	player.life += 1
	Events.emit_signal("playerBuyLife")

func _on_close_pressed():
	player.is_interacting = false
	self.queue_free()
