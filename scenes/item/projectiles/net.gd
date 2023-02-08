extends Area2D
class_name Projectile

var direction: Vector2 = Vector2.ZERO
var speed: int = 200

func _process(delta):
	position +=(Vector2.RIGHT*speed).rotated(rotation) * delta
