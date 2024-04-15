extends Node2D
signal new_signal

func play_sound(stream: AudioStream, pitch: float=1.0, volume: float=0.0) -> Signal:
	var player = AudioStreamPlayer.new()
	player.set_stream(stream)
	player.set_pitch_scale(pitch)
	player.set_autoplay(true)
	player.set_volume_db(volume)
	add_child(player)
	# player.play()
	player.finished.connect(on_finished.bind(player))
	return player.finished

func on_finished(player: AudioStreamPlayer):
	player.queue_free()
