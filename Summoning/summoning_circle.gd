extends Node2D
@onready var particles = $GPUParticles2D
@onready var timer = $Timer
@export var audio_track: AudioStream = preload ("res://Assets/SFX/summoning_3.wav")

signal stop
func start_summoning():
	particles.emitting = true
	timer.start()
	SoundPlayer.play_sound(audio_track, 1.0, -10)

func _on_timer_timeout():
	particles.emitting = false
	stop.emit()
