extends Node2D

signal ShellCollided(damageType)

var GUI_preview_over = false

func _ready():
	connect("ShellCollided", $"../RadioMessageSystem", "DummyHitResponse")

func _GUI_preview_over():
	GUI_preview_over = true

func _on_Area2D_area_entered(area):
	if GUI_preview_over == true:
		if area.name == "BlastWave":
			var shell:Node = area.get_parent().get_parent()
			shell.connect("explode", self, "blast_wave_damage")
		if area.name == "Shrapnel":
			var shell:Node = area.get_parent().get_parent()
			shell.connect("explode", self, "shrapnel_damage")

func blast_wave_damage():
		emit_signal("ShellCollided", "BlastWave")

func shrapnel_damage():
		emit_signal("ShellCollided", "Shrapnel")
