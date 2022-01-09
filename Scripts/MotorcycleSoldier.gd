extends Node2D

var arrivalSpeed = -150
var done = false
var rng = RandomNumberGenerator.new()
var bullet: PackedScene = preload("res://Props/MotorcycleSoldierBullet.tscn")
signal died(id)

func _ready():
	connect("died", $"..", "_on_Enemy_died")
	rng.randomize()
	arrivalSpeed -= rng.randi_range(0, 20)
	$Control/CenterContainer/LifePoints.text = str(15)



func _physics_process(delta):
	$LeftWheel.rotation += -15 * delta
	$RightWheel.rotation += -15 * delta
	rng.randomize()
	position.x += arrivalSpeed * delta
	if position.x <= 1300 and done == false:
		$Timer.wait_time = rng.randf_range(0.1, 0.5)
		$Timer.start()
		done = true
	if int($Control/CenterContainer/LifePoints.text) <= 0:
		emit_signal("died", get_instance_id())
		queue_free()




func _on_Timer_timeout():
	$AudioStreamPlayer.play()
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = $Muzzle.global_position
	bullet_instance.rotation = $Muzzle.global_rotation
	get_tree().get_root().add_child(bullet_instance)
	done = false


func _on_MotorcycleSoldierArea_area_entered(area):
	if area.name == "MachineGunBullet":
		$Control/CenterContainer/LifePoints.text = str(int($Control/CenterContainer/LifePoints.text) - 1)
