extends KinematicBody2D

var velocity = Vector2.ZERO

func _physics_process(delta):
	if position.x >= 1301:
		velocity += Vector2(-2, 0)
		velocity = move_and_slide_with_snap(velocity.rotated(rotation), Vector2.ZERO, -transform.y, true, 4, deg2rad(50))

