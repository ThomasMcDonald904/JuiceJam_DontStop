extends Node2D

var bullet: PackedScene = preload("res://Props/MachineGunBullet.tscn")
var done = false
func _process(delta):
	look_at(get_global_mouse_position())
	if rotation_degrees <= -29.24:
		rotation_degrees = -28.24
	elif rotation_degrees >= 18.5:
		rotation_degrees = 17.5

func _physics_process(delta):
	if Input.is_action_pressed("machineGunShoot"):
		if done == false:
			$Timer.wait_time = 6.666 * delta
			$Timer.start()
			done = true
	else:
		$Timer.stop()
		done = false


func _on_Timer_timeout():
		var bullet_instance = bullet.instance()
		bullet_instance.global_position = $BarrelMuzzle.global_position
		bullet_instance.rotation = rotation
		get_tree().get_root().add_child(bullet_instance)
		done = false
