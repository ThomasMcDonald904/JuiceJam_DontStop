extends RigidBody2D

var maxDistance = 10
var distance = 0

func _ready():
	apply_impulse(Vector2(), Vector2(1000, 0).rotated(rotation))

func _process(delta):
	print(distance)
	distance += 10 * delta
	if distance >= maxDistance:
		queue_free()
