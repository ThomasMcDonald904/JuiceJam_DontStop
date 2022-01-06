extends Label


var lifePoints = 15

func _process(delta):
	text = str(lifePoints)
	if lifePoints <= 0:
		$"../../..".queue_free()
