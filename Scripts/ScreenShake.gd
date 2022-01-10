extends Camera2D


export var shake_power = 4
export var shake_time = 0.4
var isShake = false
var curPos
var elapsedtime = 0

onready var tween_node = $Tween

func _ready():
	randomize()
	curPos = offset

func _process(delta):
	if isShake:
		shake(delta)    

func shake(delta):
	if elapsedtime<shake_time:
		offset =  Vector2(randf(), randf()) * shake_power
		elapsedtime += delta
	else:
		isShake = false
		elapsedtime = 0
		offset = curPos     

func begin_shake(power, time):
	shake_power = power
	shake_time = time
	elapsedtime = 0
	isShake = true
	tween_node.interpolate_property(self, "shake_power", shake_power, 0, time, Tween.TRANS_QUART, Tween.EASE_OUT)
	tween_node.start()


func _on_shell_exploded():
	begin_shake(20, 1)


func _on_HeavyEnemy_died(id):
	begin_shake(30, 2)


func _on_Player_shell_fired(shell):
	begin_shake(10, 0.5)
