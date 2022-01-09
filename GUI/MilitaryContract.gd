extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tween = get_node("Tween")
onready var next_item_timer = get_node("NextItemTimer")
var thrown = false
var opened = false
export(NodePath) var next_item_path
onready var next_item = get_node(next_item_path)
var toss_speed = 2000

# Called when the node enters the scene tree for the first time.
func _ready():
	$Document/PlayerName2.text = PlayerVariables.player_name
	$Document/PlayerName.text = "I, %s, accept this decree." % PlayerVariables.player_name
	$Document/Signature.text = PlayerVariables.player_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func throw_on_desk():
	thrown = true
	var travel_time = ($LetterTarget.rect_global_position - rect_global_position).length()/toss_speed
	tween.interpolate_property(self,"rect_global_position", rect_global_position, $LetterTarget.rect_global_position, travel_time)
	tween.interpolate_property(self,"rect_rotation", rect_rotation, $LetterTarget.rect_rotation, travel_time)
	if not tween.is_active():
		tween.start()

func _on_NextItemTimer_timeout():
	if next_item:
		next_item.throw_on_desk()


func _on_InputPromptDelay_timeout():
	if not opened:
		$Document/ClickPrompt.rect_rotation = -rect_rotation
		$Document/ClickPrompt.visible = true
		$Document/AnimationPlayer.play("ClickPrompt")


func _on_Tween_tween_all_completed():
	if not opened:
		$InputPromptDelay.start()


func _on_Document_pressed():
	$Document/ClickPrompt.visible = false
	$Document/AnimationPlayer.stop()
	$Document/AnimationPlayer.play("SignatureWriting")
	opened = true
	next_item_timer.start()
