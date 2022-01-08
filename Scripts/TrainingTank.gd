extends Node2D

signal ShellCollided(damageType)

var GUI_preview_over = false

func _ready():
	connect("ShellCollided", $"../RadioMessageSystem", "DummyHitResponse")

func _GUI_preview_over():
	GUI_preview_over = true

func _on_Area2D_area_entered(area):
	if GUI_preview_over == true:
		if area.name == "Shrapnel":
			emit_signal("ShellCollided", "Shrapnel")

		if area.name == "BlastWave":
			emit_signal("ShellCollided", "BlastWave")
