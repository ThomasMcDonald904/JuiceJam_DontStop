extends KinematicBody2D

var velocity = Vector2.ZERO
var gravity = 2000

func _physics_process(delta):
	velocity += Vector2(-2, 0)
	velocity.y += gravity * delta
	velocity.y = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP, false).y
