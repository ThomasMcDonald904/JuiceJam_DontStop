extends KinematicBody2D

var arrivalSpeed = -75
var velocity = Vector2.ZERO
var bullet = preload("res://Props/HeavyBullet.tscn")
var rng = RandomNumberGenerator.new()
var waitForTimer = false
var done = false
var wantedPosition = 1445

func _ready():
	rng.randomize()
	wantedPosition += rng.randi_range(0, 100)

func _physics_process(delta):
	if position.x >= wantedPosition:
		position.x += arrivalSpeed * delta
	else:
		if done == false:
			$Timer.wait_time = 2
			$Timer.start()
			done = true


func _on_Timer_timeout():
	rng.randomize()
	var bullet_instance = bullet.instance()
	add_child(bullet_instance)
	$MuzzleFlash/SoundTimer.wait_time = $MuzzleFlash/FireSound.get_stream().get_length()
	$MuzzleFlash.visible = true
	$MuzzleFlash/FireSound.play()
	$MuzzleFlash/SoundTimer.start()
	$MuzzleFlash/MuzzleFlashTimer.start()
	done = false


func _on_MuzzleFlashTimer_timeout():
	$MuzzleFlash.visible = false


func _on_FireSound_finished():
	$MuzzleFlash/FireSound.stop()


func _on_SoundTimer_timeout():
	$MuzzleFlash/FireSound.stop()


func _on_Area2D_area_entered(area):
	pass
