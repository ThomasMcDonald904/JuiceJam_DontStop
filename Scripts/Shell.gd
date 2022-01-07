extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player: Node
onready var explosionNode:Node2D = get_node("Explosion")
var ground_height_node
onready var blast_wave = $Explosion/BlastWave
onready var shrapnel = $Explosion/Shrapnel
signal explode

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation = linear_velocity.angle()
	blast_wave.global_rotation_degrees = 0;
	shrapnel.global_rotation_degrees = 0
	pass


func _on_Shell_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	emit_signal("explode")
	disconnect("explode", explosionNode, "_on_Shell_explode")
	#var cameraNode = $Camera2D
	#remove_child(cameraNode)
	#player.add_child(cameraNode)
	$Sprite.visible = false
	explosionNode.global_position.y = ground_height_node.global_position.y
	remove_child(explosionNode)
	queue_free()
