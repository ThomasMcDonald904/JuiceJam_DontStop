extends Label


var lifePoints = 15

func _process(delta):
	text = str(lifePoints)
	if lifePoints <= 0:
		$"../../..".queue_free()



func _on_Area2D_body_entered(body):
	lifePoints -= 1


func _on_Area2D_area_entered(area):
	lifePoints -= 1
