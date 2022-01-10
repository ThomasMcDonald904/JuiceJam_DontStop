extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var intro_scene = preload("res://GUI/Intro.tscn")
var map_scene = preload("res://Levels/Map.tscn")

var skip_tutorial = false
var skip_intro = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	PlayerVariables.player_name = $CanvasLayer/CenterContainer/NameEntry/VBoxContainer/HBoxContainer/NameEnter.text
	PlayerVariables.current_station = 0
	PlayerVariables.skip_tutorial = skip_tutorial
		
	if skip_intro:
		if skip_tutorial:
			PlayerVariables.current_station = 1
		get_tree().change_scene_to(map_scene)
		return
	get_tree().change_scene_to(intro_scene)


func _on_QuitButton_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_StartButton_button_down():
	$ButtonPress.play()


func _on_QuitButton_button_down():
	$ButtonPress.play()


func _on_NewGame_button_down():
	$ButtonPress.play()


func _on_NewGame_pressed():
	$CanvasLayer/CenterContainer/VBoxContainer.visible = false
	$CanvasLayer/CenterContainer/NameEntry.visible = true


func _on_NameEnter_text_changed(new_text):
	$CanvasLayer/CenterContainer/NameEntry/VBoxContainer/HBoxContainer/StartButton.disabled = false


func _on_SkipTutorialCheck_toggled(button_pressed):
	skip_tutorial = button_pressed


func _on_SkipIntroductionCheck_toggled(button_pressed):
	skip_intro = button_pressed
