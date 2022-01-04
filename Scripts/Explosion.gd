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
	$BlastWave/CollisionShape2D.disabled = false
	$Shrapnel/CollisionShape2D.disabled = false
