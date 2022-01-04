extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var elevationDegrees = 0.0
var propellantCharge = 0
onready var elevationNode = $Elevation
onready var barrelMouthNode = $Elevation/BarrelMouthNode
export(int) var healthPoints = 15
var shellInstance = null
var shellExploded = false
var shell: PackedScene = preload("res://Props/Shell.tscn")
# Called when the node enters the scene tree for the first time.

#func _ready():
#	pass # Replace with function body.

func _on_propellant_changed(value):
	propellantCharge = value


func _on_Elevation_value_changed(value):
	elevationDegrees = value
	elevationNode.rotation_degrees = -elevationDegrees

func _on_shell_exploded():
	shellExploded = true

func _on_Fire_pressed():
	shellExploded = false
	shellInstance = shell.instance()
	shellInstance.global_position = barrelMouthNode.global_position
	shellInstance.rotation = barrelMouthNode.rotation
	shellInstance.linear_velocity = Vector2(500*propellantCharge,0).rotated(deg2rad(-elevationDegrees))
	get_tree().get_root().add_child(shellInstance)
	shellInstance.connect("explode", self, "_on_shell_exploded")
	shellInstance.player = self

func _on_Area2D_body_entered(body):
	if body.is_in_group("Bullets"):
		body.queue_free()
		get_tree().get_root().get_node("Main/Control/HBoxContainer/LifePoints").lifePoints -= 1
