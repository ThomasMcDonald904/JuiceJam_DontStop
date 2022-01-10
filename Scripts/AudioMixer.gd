extends Node

onready var audio_stream_player = get_node("AudioStreamPlayer")
var rng = RandomNumberGenerator.new()
export(Array, Array, AudioStreamSample) var random_selection

func _ready():
	rng.randomize()

func play_random():
	if not audio_stream_player.playing:
		var bark_idx = rng.randi_range(0, random_selection.size()-1)
		var bark_variant = rng.randi_range(0, random_selection[bark_idx].size()-1)
		audio_stream_player.stream = random_selection[bark_idx][bark_variant]
		audio_stream_player.play()

func playing() -> bool:
	return audio_stream_player.playing
