extends KinematicBody2D

var arrivalSpeed = -100
var velocity = Vector2.ZERO
var bullet = preload("res://Props/Bullet.tscn")
var muzzleFlash = preload("res://Props/MuzzleFlash.tscn")
var rng = RandomNumberGenerator.new()
var waitForTimer = false
var done = false

func _physics_process(delta):
	if position.x >= 1301:
		position.x += arrivalSpeed * delta
	else:
		if done == false:
			$Timer.wait_time = 2
			$Timer.start()
			done = true


func _on_Timer_timeout():
	rng.randomize()
	var bullet_instance = bullet.instance()
	var muzzleFlash_instance = muzzleFlash.instance()
	muzzleFlash_instance.global_position = $Muzzle.global_position
	muzzleFlash_instance.rotation = $Muzzle.rotation
	add_child(bullet_instance)
#	add_child(muzzleFlash_instance)
	done = false


func _on_Area2D_area_entered(area):
	pass # Replace with function body.
