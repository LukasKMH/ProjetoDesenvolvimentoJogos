extends Node2D

var interactable = false

func _ready():
	respawn()
	self.visible = false

func _process(delta):
	if !interactable:
		return
	
	if Input.is_action_just_pressed("interact"):
		Events.emit_signal("playerInteractMage")

func respawn():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var x = rand.randf_range(32, 704)
	rand.randomize()
	var y = rand.randf_range(40, 416)
	
	var player = get_parent().find_child("Player")
	while player.global_position.distance_to(Vector2(x, y)) < 50.0:
		rand.randomize()
		x = rand.randf_range(32, 704)
		rand.randomize()
		y = rand.randf_range(40, 416)
	
	# TODO mago não deve dar respawn numa parede
	
	self.position.x = x
	self.position.y = y

func _on_interact_area_body_entered(body):
	if body is Player:
		interactable = true
		self.visible = true

func _on_interact_area_body_exited(body):
	if body is Player:
		interactable = false
		self.visible = false
