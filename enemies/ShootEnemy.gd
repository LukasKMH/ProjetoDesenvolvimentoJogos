extends Enemy

const Bullet = preload("res://bulletEnemy.tscn") 
var wepon = Wepon.new(3, 1.5, 100) # damage, time_shoot, bullet_velocity

func _ready():
	$ShootTimer.start(wepon.shootVelocity)
	init(15, 1, 1) # Speed, damage, life

func _physics_process(delta):
	if dead:
		return
	direction = (player.global_position - self.global_position).normalized()
	change_sprite_direction()
	velocity = direction * speed
	$aim.look_at(player.position)
	move_and_slide()

func shoot():
	if dead:
		return
	var bulletSpawnPosition = $aim/position.global_position
	var bullet = wepon.shoot(bulletSpawnPosition, player.position, Bullet)
	get_parent().add_child(bullet)

func _on_shoot_timer_timeout():
	shoot()
