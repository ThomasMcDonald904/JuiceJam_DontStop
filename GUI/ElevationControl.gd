extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var min_elevation = 0
export var max_elevation = 90
onready var readout = $HBoxContainer/Background2/Number
var elevation = 0

signal elevation_changed(value)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ElevationWheel_wheel_turned(value):
	print(value)
	elevation = clamp(elevation+value/10, min_elevation, max_elevation)
	emit_signal("elevation_changed", elevation)
	readout.text = "%2.2f°" % elevation
	pass # Replace with function body.
