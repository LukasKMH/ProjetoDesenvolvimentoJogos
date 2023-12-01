extends Node
class_name Wepon

var damage: int
var shootVelocity: float
var bulletVelocity: float

func _init(damage, shootVelocity, bulletVelocity):
	self.damage = damage
	self.shootVelocity = shootVelocity
	self.bulletVelocity = bulletVelocity

func shoot(bulletPosition, mousePosition, bulletType):
	var bullet = bulletType.instantiate()
	bullet.damage = damage
	bullet.speed = bulletVelocity
	bullet.position = bulletPosition
	bullet.direction = (mousePosition - bullet.position).normalized()
	return bullet
