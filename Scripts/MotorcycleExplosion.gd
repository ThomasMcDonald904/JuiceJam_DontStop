extends Node2D

func _ready():
	$Particles2D.emitting = true
	$AudioStreamPlayer.play()


func _on_AudioStreamPlayer_finished():
	queue_free()
