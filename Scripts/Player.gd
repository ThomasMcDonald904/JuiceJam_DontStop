extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var elevationDegrees = 0.0
var propellantCharge = 0
onready var elevationNode = $Elevation
onready var barrelMouthNode = $Elevation/BarrelMouthNode
onready var cameraNode = $Camera2D
var shellInstance = null
var shellExploded = false
var shell: PackedScene = preload("res://Props/Shell.tscn")
# Called when the node enters the scene tree for the first time.

#func _ready():
#	pass # Replace with function body.

func _physics_process(delta):
		if shellInstance != null && !shellExploded:
			cameraNode.position = shellInstance.position
		if shellExploded && Input.is_action_just_pressed("ui_accept"):
			cameraNode.offset = Vector2(415, -266)

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
