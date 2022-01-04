extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var clickPoint = Vector2(0,0)
var dragDistance = 0
var clicked = false
signal wheel_turned(value)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if clicked:
		var mousePos = get_viewport().get_mouse_position()
		var currentDragDistance = (mousePos - clickPoint).length() * sign(mousePos.x - clickPoint.x)*-1
		if currentDragDistance != 0:
			dragDistance += currentDragDistance
			emit_signal("wheel_turned", currentDragDistance)
			rect_rotation = -dragDistance
			clickPoint = get_viewport().get_mouse_position()
	pass

func _on_ElevationWheel_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				clickPoint = get_viewport().get_mouse_position()
				clicked = true
			else:
				clicked = false
	pass # Replace with function body.
