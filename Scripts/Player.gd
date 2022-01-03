extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_elevation_set(value: float):
	
	pass

func _draw():
	draw_line(global_position, global_position + Vector2(-1, 0).rotated(deg2rad(45)) * 100, Color.darkred, 10)
