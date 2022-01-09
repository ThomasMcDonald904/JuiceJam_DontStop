extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var map_scene = preload("res://Levels/Map.tscn")

export(Array, NodePath) var kill_target_paths
var kill_target_IDs =[]
signal level_end
# Called when the node enters the scene tree for the first time.
func _ready():
	for node_path in kill_target_paths:
		kill_target_IDs.append(get_node(node_path).get_instance_id())
	
func show_GUI():
	$CanvasLayer/GUI.visible = true

func _on_Enemy_died(id):
	kill_target_IDs.erase(id)
	if kill_target_IDs.empty():
		emit_signal("level_end")
	pass


func _on_LevelEndSequence_return_to_map(win):
	if win:
		PlayerVariables.current_station += 1
	get_tree().change_scene_to(map_scene)
