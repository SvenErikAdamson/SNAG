extends Area2D
class_name Projectile

var direction: Vector2 = Vector2.ZERO
var speed: int = 200

func _physics_process(delta):
	position +=(Vector2.RIGHT*speed).rotated(rotation) * delta

func _on_body_entered(body):
	##destroy bullet if hit something
	pass
