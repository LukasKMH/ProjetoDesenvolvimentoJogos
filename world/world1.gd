extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

enum {DAY, NIGHT}
var worldState

func _ready():
	Events.playerInteractMage.connect(_on_player_interact_mage)
	Events.close_mage_shop.connect(_on_mage_close_shop)
	Events.playerInteractSeller.connect(_on_player_interact_seller)
	Events.enemy_died.connect(_on_enemy_died)
	
	worldState = DAY
	startDay()

func _day_end():
	$TimerDay.stop()
	worldState = NIGHT
	removeDayElements()
	startNight()

func _night_end():
	$TimerNight.stop()
	worldState = DAY
	removeNightElements()
	startDay()

# Day Logic

@onready var mageLoad = preload("res://NPC/mage/mage.tscn")
@onready var sellerLoad = preload("res://NPC/seller/seller.tscn")
const MageShopMenu = preload("res://UI/mage_shop_gui.tscn") 
const SellerShopMenu = preload("res://UI/seller_shop_gui.tscn")

var seller_shop_menu
var day_time_left

var mage
var seller

func startDay():
	self.modulate = Color(1,1,1)
	$TimerDay.start(30)
	player.day_action()
	loadMage()
	loadSeller()

func loadMage():
	mage = mageLoad.instantiate()
	add_child(mage)

func loadSeller():
	seller = sellerLoad.instantiate()
	add_child(seller)

func removeDayElements():
	mage.queue_free()
	seller.queue_free()
	
	# Remove shop menu (the mage shop dont need this logic because it stop the time)
	if player.is_interacting:
		player.is_interacting = false
		seller_shop_menu.queue_free()

func _on_player_interact_mage():
	if !player.is_interacting:
		day_time_left = $TimerDay.time_left
		$TimerDay.stop()
		var mage_shop_menu = MageShopMenu.instantiate()
		mage_shop_menu.position = player.position
		self.add_child(mage_shop_menu)

func _on_mage_close_shop():
	$TimerDay.start(day_time_left)

func _on_player_interact_seller():
	if !player.is_interacting:
		seller_shop_menu = SellerShopMenu.instantiate()
		seller_shop_menu.position = player.position
		self.add_child(seller_shop_menu)

# Night Logic

var rand = RandomNumberGenerator.new()
var enemyscene = load("res://enemies/enemy_phase_1.tscn")

func startNight():
	self.modulate = Color(0.25,0.25,0.25)
	$TimerNight.start(160)
	player.night_action()
	spawnEnemies(20)

func spawnEnemies(numberOfEnemies):
	for i in range (0,numberOfEnemies):
		respawn_enemy()

func respawn_enemy():
	var enemy = enemyscene.instantiate()
	rand.randomize()
	var x = rand.randf_range(32, 704)
	rand.randomize()
	var y = rand.randf_range(40, 416)
	
	while player.global_position.distance_to(Vector2(x, y)) < 100.0:
		rand.randomize()
		x = rand.randf_range(32, 704)
		rand.randomize()
		y = rand.randf_range(40, 416)
	
	# TODO inimigo não deve dar respawn numa parede
	
	enemy.position.x = x
	enemy.position.y = y
	
	$Enemies.add_child(enemy)

func _on_enemy_died():
	respawn_enemy()

func removeNightElements():
	for enemy in $Enemies.get_children():
		enemy.queue_free()
