extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = get_node("../Player")

var move_speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	#_on_GUI_use_player_view()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("view_left"):
		translate(Vector2(-move_speed*delta,0))
		if position.x < 0:
			position.x = 0 
	if Input.is_action_pressed("view_right"):
		translate(Vector2(move_speed*delta,0))


func _on_GUI_use_free_view():
	pass # Replace with function body.


func _on_GUI_use_player_view():
	position.x = player.position.x


func _on_GUI_use_shell_view():
	pass # Replace with function body.
