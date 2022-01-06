extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player: Node
onready var explosionNode = get_node("Explosion")
onready var Enemy = get_tree().get_root().get_node("Main/Enemy")
onready var HeavyEnemy = get_tree().get_root().get_node("Main/HeavyEnemy")
signal explode

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation = linear_velocity.angle()
	pass


func _on_Shell_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	connect("explode", Enemy, "gotBlasted")
	connect("explode", HeavyEnemy, "gotBlasted")
	emit_signal("explode")
	disconnect("explode", explosionNode, "_on_Shell_explode")
	#var cameraNode = $Camera2D
	#remove_child(cameraNode)
	#player.add_child(cameraNode)
	$Sprite.visible = false
	
	remove_child(explosionNode)
	queue_free()
	pass # Replace with function body.
