extends Control
class_name MageShop

func _on_button_buy_velocity_pressed():
	Events.emit_signal("playerBuyVelocity")

func _on_button_buy_life_pressed():
	Events.emit_signal("playerBuyLife")

func _on_fechar_pressed():
	Events.emit_signal("close_shop")
	self.queue_free()
