extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var clickPoint = Vector2(0,0)
var dragDistance = 0
var clicked = false
var min_elevation = 0
var max_elevation = 0
signal wheel_turned(value)
var locked = false
# Called when the node enters the scene tree for the first time.
func _ready():
	min_elevation = get_node("../..").min_elevation
	max_elevation = get_node("../..").max_elevation
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if locked:
		return
	if clicked:
		var mousePos = get_viewport().get_mouse_position()
		var currentDragDistance = (clickPoint-mousePos).length() * sign(mousePos.x - clickPoint.x) * -1*delta
		if currentDragDistance != 0:
			dragDistance = clamp(dragDistance + currentDragDistance, min_elevation, max_elevation)
			emit_signal("wheel_turned", dragDistance)
			rect_rotation = -dragDistance
			#clickPoint = get_viewport().get_mouse_position()

func _on_ElevationWheel_gui_input(event: InputEvent):
	if locked:
		return
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				clickPoint = get_viewport().get_mouse_position()
				clicked = true
				$AudioStreamPlayer.play()
			else:
				clicked = false
				$AudioStreamPlayer.stop()
