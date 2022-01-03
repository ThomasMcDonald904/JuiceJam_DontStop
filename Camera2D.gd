extends Camera2D

# the size of the screen, in pixels, around all edges that
# will move the screen
const MOVEMENT_BORDER_SIZE = 150

func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	var screen_size = get_viewport().size
	# horizontal movement
	if (mouse_position.x <= MOVEMENT_BORDER_SIZE - 100):
		# move the screen left! For example:
		position.x -= 300 * delta
	elif (mouse_position.x <= MOVEMENT_BORDER_SIZE):
		# move the screen left! For example:
		position.x -= 200 * delta
	elif (mouse_position.x >= screen_size.x - MOVEMENT_BORDER_SIZE + 100):
		# move the screen left! For example:
		position.x += 300 * delta
	elif (mouse_position.x >= screen_size.x - MOVEMENT_BORDER_SIZE):
		# move the screen left! For example:
		position.x += 200 * delta


