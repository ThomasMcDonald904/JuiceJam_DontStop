extends KinematicBody2D

var arrivalSpeed = -100
var velocity = Vector2.ZERO
var bullet = preload("res://Props/Bullet.tscn")
var rng = RandomNumberGenerator.new()
var waitForTimer = false
var done = false
var inBlastWave = false
var inShrapnel = false
export var life_points = 15
signal died(id)

func _physics_process(delta):
	if position.x >= 1301:
		position.x += arrivalSpeed * delta
	else:
		if done == false:
			$Timer.wait_time = 2
			$Timer.start()
			done = true
	pass


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
	pass

func _ready():
	$Control/CenterContainer/LifePoints.text = str(15)
	connect("died", $"..", "_on_Enemy_died")
	

func _on_MuzzleFlashTimer_timeout():
	$MuzzleFlash.visible = false


func _on_FireSound_finished():
	$MuzzleFlash/FireSound.stop()


func _on_SoundTimer_timeout():
	$MuzzleFlash/FireSound.stop()


func _on_Area2D_area_entered(area):
	if area.name == "BlastWave":
		var shell:Node = area.get_parent().get_parent()
		shell.connect("explode", self, "blast_wave_damage")
		inBlastWave = true
	if area.name == "Shrapnel":
		var shell:Node = area.get_parent().get_parent()
		shell.connect("explode", self, "shrapnel_damage")
		inShrapnel = true
	pass

func blast_wave_damage():
	if inBlastWave == true:
		life_points -= 9
		$Control/CenterContainer/LifePoints.text = str(life_points)
		inBlastWave = false
		if life_points <= 0:
			emit_signal("died", get_instance_id())
			queue_free()
			$AudioMixerDestroyed.play_random()
		else:
			$AudioMixerHit.play_random()
	pass

func shrapnel_damage():
	if inShrapnel == true:
		life_points -= 6
		$Control/CenterContainer/LifePoints.text = str(life_points)
		if life_points <= 0:
			emit_signal("died", get_instance_id())
			queue_free()
			$AudioMixerDestroyed.play_random()
		else:
			$AudioMixerHit.play_random()
	pass
