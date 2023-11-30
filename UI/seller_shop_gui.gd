extends Control
class_name SellerShop

var player

func _ready():
	player = self.get_parent().find_child("Player")
	player.is_interacting = true

func _on_button_buy_wepon_2_pressed():
	var wepon = Wepon.new(2, 0.5, 300)
	player.wepon = wepon
	print(player.wepon.damage)

func _on_button_buy_wepon_1_pressed():
	var wepon = Wepon.new(1, 1, 200)
	player.wepon = wepon

func _on_close_pressed():
	player.is_interacting = false
	self.queue_free()
