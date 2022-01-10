extends Control

signal died(id)

var played_shrapnel = false
var played_blast_wave = false

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
	if DamageType == "BlastWave" && not played_blast_wave:
		$Dialog/AnimationPlayer.play("BlastWaveHit")
		played_blast_wave = true
	if DamageType == "Shrapnel" && not played_shrapnel:
		$Dialog/AnimationPlayer.play("ShrapnelHit")
		played_shrapnel = true
