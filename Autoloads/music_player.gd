extends AudioStreamPlayer

var tween: Tween
var is_audio_playing = false
var should_loop = false

@export var fade_duration: float = 2.0

func start_playing(stream: AudioStream, target_volume_db: float=0.0, loop: bool=true):
	get_tween()
	if loop:
		should_loop = true
	is_audio_playing = true
	set_stream(stream)
	_set_volume(0.0)
	play()
	tween.tween_method(_set_volume, db_to_linear(volume_db), db_to_linear(target_volume_db), fade_duration)

func stop_playing():
	if not is_audio_playing:
		return
	
	should_loop = false
	get_tween(Tween.EASE_OUT_IN)
	tween.tween_method(_set_volume, db_to_linear(volume_db), 0, fade_duration * 0.75)
	tween.tween_callback(_on_music_finished)

func _ready() -> void:
	connect("finished", _on_music_finished)

func _set_volume(volume: float) -> void:
	volume_db = linear_to_db(volume)

func _on_music_finished() -> void:
	if should_loop:
		play()
	else:
		is_audio_playing = false

func get_tween(type: Tween.EaseType=Tween.EASE_IN_OUT) -> void:
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.set_ease(type)
