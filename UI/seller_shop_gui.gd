extends Control
class_name SellerShop

@onready var weponInfo1 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/WeponInfo1
@onready var weponInfo2 = $MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2/WeponInfo2

var player

var wepon1
var wepon2

func _ready():
	player = self.get_parent().find_child("Player")
	player.is_interacting = true
	
	wepon1 = generate_random_wepon()
	wepon2 = generate_random_wepon()
	show_wepon()

func generate_random_wepon():
	var random_damage = randi_range(1, 5)
	var random_shoot_velocity = randf_range(0.3, 3.0)
	var random_bullet_velocity = randi_range(150, 800)
	return Wepon.new(random_damage, random_shoot_velocity, random_bullet_velocity)

func show_wepon():
	weponInfo1.text = "Dano: " + str(wepon1.damage) + "\nTiro/s: " + str(wepon1.shootVelocity).pad_decimals(2) + "\nVelocidade: " + str(wepon1.bulletVelocity)
	weponInfo2.text = "Dano: " + str(wepon2.damage) + "\nTiro/s: " + str(wepon2.shootVelocity).pad_decimals(2) + "\nVelocidade: " + str(wepon2.bulletVelocity)

func _on_button_buy_wepon_2_pressed():
	player.wepon = wepon2

func _on_button_buy_wepon_1_pressed():
	player.wepon = wepon1

func _on_close_pressed():
	player.is_interacting = false
	self.queue_free()
