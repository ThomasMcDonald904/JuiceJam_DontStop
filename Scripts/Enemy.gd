extends KinematicBody2D

var arrivalSpeed = -100
var velocity = Vector2.ZERO
var bullet = preload("res://Props/Bullet.tscn")
var rng = RandomNumberGenerator.new()
var waitForTimer = false
var done = false
var inBlastWave = false
var inShrapnel = false

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
	if area.name == "BlastWave":
		inBlastWave = true
	if area.name == "Shrapnel":
		inShrapnel = true

func gotBlasted():
	if inBlastWave == true:
		$Control/CenterContainer/LifePoints.lifePoints -= 9
		inBlastWave = false
	if inShrapnel == true:
		$Control/CenterContainer/LifePoints.lifePoints -= 6
		inShrapnel = false
