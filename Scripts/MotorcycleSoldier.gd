extends Node2D

var arrivalSpeed = -150
var done = false
var rng = RandomNumberGenerator.new()
var bullet: PackedScene = preload("res://Props/MotorcycleSoldierBullet.tscn")
signal died(id)
var inBlastWave = false
var inShrapnel = false
export var life_points = 5

func _ready():
	connect("died", $"..", "_on_Enemy_died")
	rng.randomize()
	arrivalSpeed -= rng.randi_range(0, 20)
	$Control/CenterContainer/LifePoints.text = str(life_points)



func _physics_process(delta):
	$LeftWheel.rotation += -15 * delta
	$RightWheel.rotation += -15 * delta
	rng.randomize()
	position.x += arrivalSpeed * delta
	if position.x <= 1300 and done == false:
		$Timer.wait_time = rng.randf_range(0.1, 0.5)
		$Timer.start()
		done = true




func _on_Timer_timeout():
	$AudioStreamPlayer.play()
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = $Muzzle.global_position
	bullet_instance.rotation = $Muzzle.global_rotation
	get_tree().get_root().add_child(bullet_instance)
	done = false


func _on_MotorcycleSoldierArea_area_entered(area):
	if area.name == "MachineGunBullet":
		bullet_damage()
	if area.name == "BlastWave":
		var shell:Node = area.get_parent().get_parent()
		shell.connect("explode", self, "blast_wave_damage")
		inBlastWave = true
	if area.name == "Shrapnel":
		var shell:Node = area.get_parent().get_parent()
		shell.connect("explode", self, "shrapnel_damage")
		inShrapnel = true

func blast_wave_damage():
	if inBlastWave == true:
		life_points -= 9
		$Control/CenterContainer/LifePoints.text = str(life_points)
		inBlastWave = false
		if life_points <= 0:
			emit_signal("died", get_instance_id())
			queue_free()

func bullet_damage():
	life_points -= 1
	$Control/CenterContainer/LifePoints.text = str(life_points)
	if life_points <= 0:
			emit_signal("died", get_instance_id())
			queue_free()


func shrapnel_damage():
	if inShrapnel == true:
		life_points -= 6
		$Control/CenterContainer/LifePoints.text = str(life_points)
		if life_points <= 0:
			emit_signal("died", get_instance_id())
			queue_free()
