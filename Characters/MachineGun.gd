extends Node2D

var bullet: PackedScene = preload("res://Props/MachineGunBullet.tscn")
export var rate_of_fire = 4
var time_to_next_bullet = 0

func _process(delta):
	look_at(get_global_mouse_position())
	if rotation_degrees <= -29.24:
		rotation_degrees = -28.24
	elif rotation_degrees >= 18.5:
		rotation_degrees = 17.5

func _physics_process(delta):
	if Input.is_action_pressed("machineGunShoot"):
		time_to_next_bullet -= delta
		if time_to_next_bullet <= 0:
			_on_fire_bullet()
			time_to_next_bullet = 1.0/rate_of_fire
	else:
		time_to_next_bullet = 0

func _on_fire_bullet():
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = $BarrelMuzzle.global_position
	bullet_instance.rotation = rotation
	get_tree().get_root().add_child(bullet_instance)
