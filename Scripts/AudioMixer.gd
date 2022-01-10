extends Node

onready var audio_stream_player = get_node("AudioStreamPlayer")
var rng = RandomNumberGenerator.new()
export(Array, Array, AudioStreamSample) var random_selection

var unplayed_barks = []

func _ready():
	rng.randomize()
	for n in range(0,random_selection.size()):
		unplayed_barks.append(n)

func play_random():
	if unplayed_barks.size() == 0:
		for n in range(0,random_selection.size()):
			unplayed_barks.append(n)
	if not audio_stream_player.playing:
		var bark_idx = unplayed_barks[rng.randi_range(0, unplayed_barks.size()-1)]
		unplayed_barks.erase(bark_idx)
		var bark_variant = rng.randi_range(0, random_selection[bark_idx].size()-1)
		audio_stream_player.stream = random_selection[bark_idx][bark_variant]
		audio_stream_player.play()

func playing() -> bool:
	return audio_stream_player.playing
