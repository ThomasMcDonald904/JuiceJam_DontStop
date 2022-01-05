extends Node2D

func _ready():
	$AudioStreamPlayer.play()
	$Timer.wait_time = 0.5
	$Timer.start()


func _on_Timer_timeout():
	$Sprite.visible = false



func _on_AudioStreamPlayer_finished():
	queue_free()
