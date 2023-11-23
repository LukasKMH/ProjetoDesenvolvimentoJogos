extends CharacterBody2D
class_name Bullet

var direction: Vector2
var speed = 200

func _physics_process(delta):
	var collisionDetails = move_and_collide(direction * delta * speed)
	
	on_collision(collisionDetails)

func on_collision(collisionDetails):
	if collisionDetails:
		var body = collisionDetails.get_collider()
		if body is Enemy:
			body.die()
			self.queue_free()
		#if body is Wall:
		#	self.queue_free()
