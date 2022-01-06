extends Area2D
var areaRID

func _physics_process(delta):
	for area in get_overlapping_areas():
		if area.name == "BlastWave" and area.get_id() != areaRID:
			$"../Control/CenterContainer/LifePoints".lifePoints -= 9
			areaRID = area.get_id()
