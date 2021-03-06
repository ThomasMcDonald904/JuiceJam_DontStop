extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var elevationDegrees = 0.0
var propellantCharge = 0
export var propellant_power = 0.5
export(NodePath) var ground_height_node_path
onready var ground_height_node = get_node(ground_height_node_path)
onready var elevationNode = $Elevation
onready var barrelMouthNode = $Elevation/BarrelMouthNode
export(int) var healthPoints = 15
export(int) var maxHealthPoints = 15
var shellInstance = null
var shellExploded = false
var shell: PackedScene = preload("res://Props/Shell.tscn")
var motorcycleExplosion: PackedScene = preload("res://Props/MotorcycleExplosion.tscn")
export var reloading = false
export var can_reload = true
var map: PackedScene = preload("res://Levels/Map.tscn")
var life_currently_lost = 0
var life_bark_threshold = 5
var low_health_bark_played = false

signal life_changed(value)
signal shell_fired(shell)
signal shell_exploded
signal reloading
signal reloaded
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

func _on_propellant_changed(value):
	propellantCharge = value

func _on_shell_exploded():
	emit_signal("shell_exploded")
	shellExploded = true

func _on_Area2D_body_entered(body):
	if body.is_in_group("Bullets"):
		body.queue_free()
		healthPoints -= 1
		life_currently_lost += 1
		emit_signal("life_changed", healthPoints)
	if body.is_in_group("MotorcycleBullets"):
		body.queue_free()
		healthPoints -= 0.5
		life_currently_lost += 0.5
		emit_signal("life_changed", healthPoints)
		
	if life_currently_lost >= life_bark_threshold:
		if healthPoints < maxHealthPoints/2:
			if healthPoints <= maxHealthPoints/4:
				if not $Audio/CriticalStatus.playing():
					$Audio/CriticalStatus.play_random()
			else:
				if not $Audio/LowHealth.playing():
					$Audio/LowHealth.play_random()
		else:
			if not $Audio/GettingHit.playing():
				$Audio/GettingHit.play_random()


func _on_ElevationControl_elevation_changed(value):
	if not reloading:
		elevationDegrees = value
		elevationNode.rotation_degrees = -elevationDegrees

func _process(delta):
	if reloading && can_reload:
		var reload_animation: Animation = $ReloadSequence/SequenceCoordinator.get_animation("Reload")
		reload_animation.track_set_key_value(1, 0, elevationNode.rotation_degrees)
		$ReloadSequence/SequenceCoordinator.play("Reload")
		elevationDegrees = 0
		emit_signal("reloading")
	if healthPoints <= 0:
		$"../CanvasLayer/LevelEndSequence/AnimationPlayer".play("FadeToBlackDeath")

func _on_FireButton_pressed():
	if not reloading:
		shellExploded = false
		shellInstance = shell.instance()
		shellInstance.ground_height_node = ground_height_node
		shellInstance.global_position = barrelMouthNode.global_position
		shellInstance.rotation = barrelMouthNode.rotation
		shellInstance.linear_velocity = Vector2(500*propellantCharge*propellant_power,0).rotated(deg2rad(-elevationDegrees))
		get_tree().get_root().add_child(shellInstance)
		emit_signal("shell_fired", shellInstance)
		shellInstance.connect("explode", self, "_on_shell_exploded")
		shellInstance.player = self
		$Audio/Firing.play_random()
		reloading = true
	

func _on_GUI_propellant_added():
	propellantCharge += 1
	$Audio/AddingPropellant.play_random()


func _on_GUI_propellant_removed():
	propellantCharge -= 1
	$Audio/RemovingPropellant.play_random()


func _on_GUI_use_free_view():
	pass # Replace with function body.


func _on_SequenceCoordinator_animation_finished(anim_name):
	if anim_name == "Reload":
		$ReloadSequence/AnimationPlayer.play("RetractPusher")
		$Audio/Reloading.play_random()
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	if area.name == "MotorcycleSoldierArea":
		var motorcycleExplosion_instance = motorcycleExplosion.instance()
		motorcycleExplosion_instance.global_position = area.global_position
		get_tree().get_root().add_child(motorcycleExplosion_instance)
		area.get_parent().queue_free()
		healthPoints -= 5
		emit_signal("life_changed", healthPoints)


func _on_AnimationPlayer_animation_finished(anim_name):
	pass
