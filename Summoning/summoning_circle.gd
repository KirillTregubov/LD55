extends Node2D
@onready var particles = $GPUParticles2D
@onready var timer = $Timer
@onready var sound = $SFX

func start_summoning():
	particles.emitting = true
	timer.start()
	sound.play()

func _on_timer_timeout():
	particles.emitting = false
