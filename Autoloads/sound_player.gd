extends Node2D
signal new_signal

@onready var sound_stream: AudioStream = preload ("res://Assets/SFX/option_click.wav")
@export var select_stream: AudioStream = preload ("res://Assets/SFX/select.wav")

func play_sound(stream: AudioStream, pitch: float=1.0, volume: float=0.0) -> Signal:
	var player = AudioStreamPlayer.new()
	player.set_stream(stream)
	player.set_pitch_scale(pitch)
	player.set_autoplay(true)
	player.set_volume_db(volume)
	add_child(player)
	player.finished.connect(on_finished.bind(player))
	return player.finished

func play_button_sound() -> Signal:
	var player = AudioStreamPlayer.new()
	player.process_mode = PROCESS_MODE_ALWAYS
	player.set_stream(sound_stream)
	player.set_autoplay(true)
	add_child(player)
	player.finished.connect(on_finished.bind(player))
	return player.finished

func play_select_sound() -> Signal:
	var player = AudioStreamPlayer.new()
	player.process_mode = PROCESS_MODE_ALWAYS
	player.set_stream(select_stream)
	player.set_autoplay(true)
	add_child(player)
	player.finished.connect(on_finished.bind(player))
	return player.finished

func on_finished(player: AudioStreamPlayer):
	player.queue_free()
