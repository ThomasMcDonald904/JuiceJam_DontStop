extends RigidBody2D

var maxDistance = 10
var distance = 0

func _ready():
	apply_impulse(Vector2(), Vector2(1500, 0).rotated(rotation))

func _process(delta):
	distance += 10 * delta
	if distance >= maxDistance:
		queue_free()


func _on_MachineGunBullet_area_entered(area):
	if area.get_owner().name != "Player":
		queue_free()


func _on_MachineGunBullet_body_entered(body):
	if body.name != "Player":
		queue_free()
