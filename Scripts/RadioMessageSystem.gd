extends Control

signal died(id)

func _ready():
	connect("died", $"..",  "_on_Enemy_died")
	$Dialog/AnimationPlayer.play("TutorialStart")


func start_dialogue(dialog_name: String):
	$Dialog/AnimationPlayer.play(dialog_name)

func reset():
	$Dialog/AnimationPlayer.play("RESET")

func dieSignal():
	emit_signal("died", $"../TrainingTank".get_instance_id())

func DummyHitResponse(DamageType):
	if DamageType == "BlastWave":
		$Dialog/AnimationPlayer.play("BlastWaveHit")
	if DamageType == "Shrapnel":
		$Dialog/AnimationPlayer.play("ShrapnelHit")
