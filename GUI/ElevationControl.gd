extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var min_elevation = 0
export var max_elevation = 90
onready var readout = $HBoxContainer/Background2/Number
onready var elevation_wheel = $HBoxContainer/ElevationWheel
var elevation = 0

signal elevation_changed(value)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ElevationWheel_wheel_turned(value):
	elevation = value
	emit_signal("elevation_changed", elevation)
	readout.text = "%2.2f°" % elevation
	pass # Replace with function body.


func _on_Player_elevation_reset():
	elevation = 0
	readout.text = "%2.2f°" % elevation
	elevation_wheel.dragDistance = 0
	pass # Replace with function body.


func _on_Player_reloading():
	elevation = 0
	readout.text = "%2.2f°" % elevation
	elevation_wheel.dragDistance = 0
	elevation_wheel.locked = true
	pass # Replace with function body.


func _on_Player_reloaded():
	elevation_wheel.locked = false
	pass # Replace with function body.
