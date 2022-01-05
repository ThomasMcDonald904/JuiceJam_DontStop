extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal use_player_view
signal use_free_view
signal use_shell_view
onready var tween: Tween = $HBoxContainer/Status/LifeAndAmmo/Tween
var animated_health = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_node_or_null("../../Player")
	if player:
		animated_health = player.maxHealthPoints
		$HBoxContainer/Status/LifeAndAmmo/Bar/Gauge.max_value = animated_health
		$HBoxContainer/Status/LifeAndAmmo/Bar/Gauge.value = animated_health
		$HBoxContainer/Status/LifeAndAmmo/Bar/Count/Background/Number.text = String(animated_health)
	var playerButton = get_node("HBoxContainer/ViewSelect/PlayerView")
	playerButton.pressed = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HBoxContainer/Status/LifeAndAmmo/Bar/Gauge.value = animated_health
	pass

func _on_PlayerView_toggled(button_pressed):
	if button_pressed:
		emit_signal("use_player_view")
		var rangeFinderButton = get_node("HBoxContainer/ViewSelect/RangeFinderView")
		rangeFinderButton.set_pressed_no_signal(false)
		var shellViewButton = get_node("HBoxContainer/ViewSelect/ShellView")
		shellViewButton.set_pressed_no_signal(false)


func _on_RangeFinderView_toggled(button_pressed):
	if button_pressed:
		emit_signal("use_free_view")
		var playerButton = get_node("HBoxContainer/ViewSelect/PlayerView")
		playerButton.set_pressed_no_signal(false)
		var shellViewButton = get_node("HBoxContainer/ViewSelect/ShellView")
		shellViewButton.set_pressed_no_signal(false)


func _on_ShellView_toggled(button_pressed):
	if button_pressed:
		emit_signal("use_shell_view")
		var rangeFinderButton = get_node("HBoxContainer/ViewSelect/RangeFinderView")
		rangeFinderButton.set_pressed_no_signal(false)
		var playerButton = get_node("HBoxContainer/ViewSelect/PlayerView")
		playerButton.set_pressed_no_signal(false)


func _on_Player_life_changed(new_value):
	$HBoxContainer/Status/LifeAndAmmo/Bar/Count/Background/Number.text = String(new_value)
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6)
	if not tween.is_active():
		tween.start()
	pass # Replace with function body.
