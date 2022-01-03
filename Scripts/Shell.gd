extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation = linear_velocity.angle()
	pass


func _on_Shell_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("explode")
	var cameraNode = $Camera2D
	remove_child(cameraNode)
	player.add_child(cameraNode)
	queue_free()
	pass # Replace with function body.
