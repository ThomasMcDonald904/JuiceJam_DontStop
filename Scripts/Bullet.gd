extends KinematicBody2D

onready var muzzle = get_node("../Muzzle")
var speed = 588
var distanceTravelled = 0
var distance = 0
var isStopped = false

func _ready():
	global_position = muzzle.global_position
	rotation = muzzle.rotation
	self.speed = speed

func _physics_process(delta):
	var collider = move_and_collide(get_global_transform().basis_xform(Vector2.RIGHT * speed * delta))
