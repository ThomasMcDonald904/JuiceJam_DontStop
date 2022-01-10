extends Node2D
class_name Explosion

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Shell_explode():
	var globalPos = global_position
	var root = get_tree().get_root()
	get_parent().remove_child(self)
	root.add_child(self)
	global_position = globalPos
	$FragmentDust.emitting = true
	$Explosion.emitting = true
	$Explosion2.emitting = true
	$Explosion3.emitting = true
	$PrincipalExplosion.emitting = true
	$BlastWave/CollisionShape2D.set_deferred("disabled", false)
	$Shrapnel/CollisionShape2D.set_deferred("disabled", false)
	$CollisionKillTimer.start()
	$FxKillTimer.start()
	$AudioStreamPlayer2D.play()

func _on_FxKillTimer_timeout():
	queue_free()


func _on_CollisionKillTimer_timeout():
	$BlastWave/CollisionShape2D.set_deferred("disabled", true)
	$Shrapnel/CollisionShape2D.set_deferred("disabled", true)
