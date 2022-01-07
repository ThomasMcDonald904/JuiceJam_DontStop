extends Node2D

onready var tween = get_node("Tween")
var start = true
signal GoToNextStation
var next_level
#Change the place holder "LevelName" to the path to the scene you want to change to
var stations = [["NoSceneHere", 0], ["res://Levels/Level1.tscn", 295.04], ["res://Levels/Level2.tscn", 727.78], ["res://Levels/Level3.tscn", 1180.18], ["res://Levels/Level4.tscn", 1370.86], ["res://Levels/FinalWords.tscn", 1593.24], ]
#Change this to change at which station the trains starts at

var nextStation = 0
#Change this to change how long the train movement takes
var TrainTime = 6

func _ready():
	nextStation = PlayerVariables.current_station + 1
	$RailwayPath/PathFollow2D.offset = stations[PlayerVariables.current_station][1]
	connect("GoToNextStation", self, "_nextStation")

func _process(delta):
	if start:
		next_level = load(stations[nextStation][0])
		tween.interpolate_property($RailwayPath/PathFollow2D, "offset", $RailwayPath/PathFollow2D.offset, stations[nextStation][1], TrainTime, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
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


func _on_Tween_tween_all_completed():
	get_tree().change_scene_to(next_level)
