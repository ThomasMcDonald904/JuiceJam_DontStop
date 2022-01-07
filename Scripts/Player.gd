extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var elevationDegrees = 0.0
var propellantCharge = 0
export(NodePath) var ground_height_node_path
onready var ground_height_node = get_node(ground_height_node_path)
onready var elevationNode = $Elevation
onready var barrelMouthNode = $Elevation/BarrelMouthNode
export(int) var healthPoints = 15
export(int) var maxHealthPoints = 15
var shellInstance = null
var shellExploded = false
var shell: PackedScene = preload("res://Props/Shell.tscn")

signal life_changed(value)
signal shell_fired(shell)
signal shell_exploded
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
		emit_signal("life_changed", healthPoints)


func _on_ElevationControl_elevation_changed(value):
	elevationDegrees = value
	elevationNode.rotation_degrees = -elevationDegrees


func _on_FireButton_pressed():
	
	shellExploded = false
	shellInstance = shell.instance()
	shellInstance.ground_height_node = ground_height_node
	shellInstance.global_position = barrelMouthNode.global_position
	shellInstance.rotation = barrelMouthNode.rotation
	shellInstance.linear_velocity = Vector2(500*propellantCharge,0).rotated(deg2rad(-elevationDegrees))
	get_tree().get_root().add_child(shellInstance)
	emit_signal("shell_fired", shellInstance)
	shellInstance.connect("explode", self, "_on_shell_exploded")
	shellInstance.player = self


func _on_GUI_propellant_added():
	propellantCharge += 1


func _on_GUI_propellant_removed():
	propellantCharge -= 1


func _on_GUI_use_free_view():
	pass # Replace with function body.
