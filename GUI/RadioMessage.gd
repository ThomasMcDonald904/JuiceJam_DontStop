extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var tween = get_node("Tween")
onready var next_item_timer = get_node("NextItemTimer")
var thrown = false
var opened = false
export var auto_play_message = false
export var click_to_continue = false
export(NodePath) var next_item_path
onready var next_item = get_node(next_item_path)
var toss_speed = 2000
signal message_done
var message_is_done = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialog.visible = false
	$TextureButton/ClickPrompt.visible = false
	pass # Replace with function body.

func throw_on_desk():
	thrown = true
	var travel_time = ($TossTarget.rect_global_position - rect_global_position).length()/toss_speed
	tween.interpolate_property(self,"rect_global_position", rect_global_position, $TossTarget.rect_global_position, travel_time)
	tween.interpolate_property(self,"rect_rotation", rect_rotation, $TossTarget.rect_rotation, travel_time)
	if not tween.is_active():
		tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	if not message_is_done:
		$TextureButton/Switch.texture.region = Rect2(20,0,20,18)
		$SwitchSound.play()
		$TextureButton/ClickPrompt.visible = false
		$TextureButton/AnimationPlayer.stop()
		opened = true
		$Dialog.rect_rotation = -rect_rotation
		$Dialog.visible = true
		$Dialog/AnimationPlayer.play("IntroDialogAnimation")
	elif click_to_continue:
		$TextureButton/ClickPrompt.visible = false
		$TextureButton/AnimationPlayer.stop()
		next_item.throw_on_desk()
		click_to_continue = false

func _on_Tween_tween_all_completed():
	if auto_play_message:
		_on_TextureButton_pressed()
	else:	
		if not opened:
			$InputPromptDelay.start()
		
func _on_InputPromptDelay_timeout():
	if not opened:
		$TextureButton/ClickPrompt.rect_rotation = -rect_rotation
		$TextureButton/ClickPrompt.visible = true
		$TextureButton/AnimationPlayer.play("GUIClickPrompt")

func _on_NextItemTimer_timeout():
	if next_item:
		if click_to_continue:
			$TextureButton/ClickPrompt.rect_rotation = -rect_rotation
			$TextureButton/ClickPrompt.visible = true
			$TextureButton/AnimationPlayer.play("GUIClickPrompt")
		else:
			next_item.throw_on_desk()
		
func message_is_done():
	message_is_done = true
	emit_signal("message_done")
