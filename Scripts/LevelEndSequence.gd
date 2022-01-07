extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal return_to_map
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Main_level_end():
	$RadioMessage.throw_on_desk()

func _on_level_end():
	$RadioMessage.throw_on_desk()

func throw_on_desk():
	$AnimationPlayer.play("FadeToBlack")
