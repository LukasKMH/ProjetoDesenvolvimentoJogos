extends CharacterBody2D

var player

enum {IDLE, RUN, SELL}
var state

const SPEED = 25.0

func _ready():
	respawn()
	player = get_parent().find_child("Player")
	state = IDLE

func _physics_process(delta):
	match state:
		IDLE:
			pass
		RUN:
			run()
		SELL:
			sell()

func run():
	var direction = (player.global_position - global_position).normalized()
	velocity = -direction * SPEED
	change_sprite_direction(direction)
	move_and_slide()

func sell():
	if Input.is_action_just_pressed("interact"):
		Events.emit_signal("playerInteractSeller")

func _on_run_area_body_entered(body):
	state = RUN

func _on_run_area_body_exited(body):
	state = IDLE

func _on_trade_area_body_entered(body):
	state = SELL

func _on_trade_area_body_exited(body):
	state = RUN

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
	
	# TODO vendedor não deve dar respawn numa parede
	
	self.position.x = x
	self.position.y = y

func change_sprite_direction(direction):
	if direction.x < 0:
		$sprite.flip_h = false
	elif direction.x > 0:
		$sprite.flip_h = true
