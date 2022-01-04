extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var loadIndicatiors = [$VBoxContainer/PropControl/LoadedProp/HBoxContainer/Load1
					,$VBoxContainer/PropControl/LoadedProp/HBoxContainer/Load2
					,$VBoxContainer/PropControl/LoadedProp/HBoxContainer/Load3
					,$VBoxContainer/PropControl/LoadedProp/HBoxContainer/Load4 ]

var loadedPropellant = 0
export var emptySlot: Texture
export var fullSlot: Texture

signal propellant_changed(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_propellant():
	for n in loadedPropellant:
		loadIndicatiors[n].texture = fullSlot
	for n in range(loadedPropellant, 4):
		loadIndicatiors[n].texture = emptySlot
	emit_signal("propellant_changed", loadedPropellant)

func _on_increase_propellant():
	loadedPropellant = min(4, loadedPropellant+1)
	update_propellant()

func _on_decrease_propellant():
	loadedPropellant = max(0, loadedPropellant-1)
	update_propellant()
