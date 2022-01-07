extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var main_menu = preload("res://GUI/MainMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/PanelContainer/PlayerName.text = PlayerVariables.player_name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_EndGame_button_down():
	$AudioStreamPlayer.play()
	pass # Replace with function body.


func _on_EndGame_pressed():
	get_tree().change_scene_to(main_menu)
