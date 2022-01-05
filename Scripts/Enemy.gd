extends KinematicBody2D

var velocity = Vector2.ZERO
var bullet = preload("res://Props/Bullet.tscn")
var rng = RandomNumberGenerator.new()
var waitForTimer = false
var done = false

func _physics_process(delta):
	if position.x >= 1301:
		velocity += Vector2(-2, 0)
		velocity = move_and_slide_with_snap(velocity.rotated(rotation), Vector2.ZERO, -transform.y, true, 4, deg2rad(50))
	else:
		if done == false:
			$Timer.wait_time = 2
			$Timer.start()
			done = true


func _on_Timer_timeout():
	rng.randomize()
	var bullet_instance = bullet.instance()
	add_child(bullet_instance)
	done = false


func _on_Area2D_area_entered(area):
	pass # Replace with function body.
