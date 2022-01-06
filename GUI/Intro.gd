extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var map_scene = preload("res://Levels/Map.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_FirstLetterTimer_timeout():
	$TelegramLetter.throw_on_desk()

func throw_on_desk():
	$FadeToBlack.visible = true
	$AnimationPlayer.play("FadeToBlack")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeToBlack":
		get_tree().change_scene_to(map_scene)
