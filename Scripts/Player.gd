extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var elevationDegrees = 0.0
onready var elevationNode = $Elevation
onready var barrelMouthNode = $Elevation/BarrelMouthNode
onready var cameraNode = $Camera2D

var shell: PackedScene = preload("res://Props/Shell.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_elevation_set(value: float):
	elevationDegrees = value
	elevationNode.rotation_degrees = -elevationDegrees
	pass

func on_fire():
	var shellInstance = shell.instance()
	shellInstance.global_position = barrelMouthNode.global_position
	shellInstance.rotation = barrelMouthNode.rotation
	shellInstance.linear_velocity = Vector2(500,0).rotated(deg2rad(-elevationDegrees))
	get_tree().get_root().add_child(shellInstance)
	cameraNode.get_parent().remove_child(cameraNode)
	cameraNode.position = Vector2(0,0)
	shellInstance.add_child(cameraNode)
	shellInstance.player = self
	pass

func _draw():
	draw_line(global_position, global_position + Vector2(-1, 0).rotated(deg2rad(45)) * 100, Color.darkred, 10)
