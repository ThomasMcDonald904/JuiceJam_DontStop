extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal propellant_added
signal propellant_removed

export var max_charges = 4
var current_charges = 0

var propellantCharge: PackedScene = preload("res://GUI/Propellant.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Propellant_RemoveButton_pressed():
	var container = get_node("HBoxContainer")
	if container.get_child_count() > 1:
		container.remove_child(container.get_child(0))
		current_charges -= 1
		emit_signal("propellant_removed")


func _on_AddChargesButton_pressed():
	if current_charges < max_charges:
		current_charges += 1
		var charge = propellantCharge.instance()
		charge.get_child(1).connect("pressed", self, "_on_Propellant_RemoveButton_pressed")
		var container = get_node("HBoxContainer")
		container.add_child(charge)
		container.move_child(charge, 0)
		emit_signal("propellant_added")
