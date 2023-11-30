extends CharacterBody2D
class_name Bullet

var direction: Vector2
var speed = 200
var damage = 1

func _physics_process(delta):
	var collisionDetails = move_and_collide(direction * delta * speed)
	
	on_collision(collisionDetails)

func on_collision(collisionDetails):
	if collisionDetails:
		var body = collisionDetails.get_collider()
		if body is Enemy:
			body.get_damage(self.damage)
			body.knockback(self.velocity)
		self.queue_free()
