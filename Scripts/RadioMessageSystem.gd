extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	start_dialogue("TutorialStart")
	pass # Replace with function body.

func start_dialogue(dialog_name: String):
	$Dialog/AnimationPlayer.play(dialog_name)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	$MessageHideTimer.start()
	pass # Replace with function body.


func _on_MessageHideTimer_timeout():
	$Dialog/AnimationPlayer.play("RESET")
