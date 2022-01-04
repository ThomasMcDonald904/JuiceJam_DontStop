extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal use_player_view
signal use_free_view
signal use_shell_view

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_PlayerView_toggled(button_pressed):
	if button_pressed:
		emit_signal("use_player_view")
		var rangeFinderButton = get_node("HBoxContainer/ViewSelect/RangeFinderView")
		rangeFinderButton.set_pressed_no_signal(false)
		var shellViewButton = get_node("HBoxContainer/ViewSelect/ShellView")
		shellViewButton.set_pressed_no_signal(false)


func _on_RangeFinderView_toggled(button_pressed):
	if button_pressed:
		emit_signal("use_free_view")
		var playerButton = get_node("HBoxContainer/ViewSelect/PlayerView")
		playerButton.set_pressed_no_signal(false)
		var shellViewButton = get_node("HBoxContainer/ViewSelect/ShellView")
		shellViewButton.set_pressed_no_signal(false)


func _on_ShellView_toggled(button_pressed):
	if button_pressed:
		emit_signal("use_shell_view")
		var rangeFinderButton = get_node("HBoxContainer/ViewSelect/RangeFinderView")
		rangeFinderButton.set_pressed_no_signal(false)
		var playerButton = get_node("HBoxContainer/ViewSelect/PlayerView")
		playerButton.set_pressed_no_signal(false)
