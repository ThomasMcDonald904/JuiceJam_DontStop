extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var player_node_path = ""
onready var player: Node2D = get_node(player_node_path)
enum VIEWS {FREE_VIEW, PLAYER_VIEW, SHELL_VIEW}
var current_viewmode = VIEWS.PLAYER_VIEW
var move_speed = 500
var shell_active = false
var target_shell
export var player_view_offset = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_viewmode == VIEWS.SHELL_VIEW:
		if shell_active:
			position.x = target_shell.position.x
		else:
			if Input.is_action_just_pressed("view_left") || Input.is_action_just_pressed("view_right"):
				position.x = player.position.x
	elif current_viewmode == VIEWS.PLAYER_VIEW:
		if Input.is_action_pressed("view_left"):
			translate(Vector2(-move_speed*delta,0))
			if position.x < 0:
				position.x = 0 
		if Input.is_action_pressed("view_right"):
			translate(Vector2(move_speed*delta,0))
		if Input.is_action_just_released("view_left") || Input.is_action_just_released("view_right"):
			position.x = player.position.x + player_view_offset

func _input(event):
	if !shell_active && (event is InputEventMouseButton || event is InputEventKey):
		if current_viewmode == VIEWS.SHELL_VIEW:
			position.x = player.position.x + player_view_offset

func _on_GUI_use_free_view():
	pass # Replace with function body.


func _on_GUI_use_player_view():
	current_viewmode = VIEWS.PLAYER_VIEW
	position.x = player.position.x + player_view_offset


func _on_GUI_use_shell_view():
	current_viewmode = VIEWS.SHELL_VIEW
	pass # Replace with function body.


func _on_Player_shell_fired(shell: Node2D):
	target_shell = shell
	shell_active = true


func _on_Player_shell_exploded():
	shell_active = false
