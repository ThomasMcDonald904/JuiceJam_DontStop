extends Node2D

onready var tween = get_node("Tween")
var start = false
signal GoToNextStation
#Change the place holder "LevelName" to the path to the scene you want to change to
var stations = [["NoSceneHere", 0], ["res://Levels/Main.tscn", 295.04], ["LevelName", 727.78], ["LevelName", 1180.18], ["LevelName", 1593.24]]
#Change this to change at which station the trains starts at
var startingStation = 0
var nextStation = startingStation + 1
#Change this to change how long the train movement takes
var TrainTime = 3

func _ready():
	$RailwayPath/PathFollow2D.offset = stations[startingStation][1]
	connect("GoToNextStation", self, "_nextStation")

func _process(delta):
	if Input.is_action_pressed("up_arrow"):
		start = true
	else:
		start = false

	if start == true:
		tween.interpolate_property($RailwayPath/PathFollow2D, "offset", $RailwayPath/PathFollow2D.offset, stations[nextStation][1], TrainTime, Tween.TRANS_QUINT, Tween.EASE_OUT)
		$Timer.wait_time = TrainTime
		tween.start()
		$Timer.start()
		start = false

# This is called when the train arrives at the to be station
func _nextStation():
	print("Arrived")
	nextStation += 1



func _on_Timer_timeout():
	emit_signal("GoToNextStation")
