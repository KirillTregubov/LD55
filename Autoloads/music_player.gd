extends AudioStreamPlayer

var is_audio_playing = false
var should_loop = false
@export var fade_duration: float = 2.0

@export_range(-80, 24) var target_volume_db

func start_playing(loop: bool=true):
	var tween = get_tween()
	if loop:
		should_loop = true
	is_audio_playing = true
	_set_volume(0.0)
	tween.tween_method(_set_volume, db_to_linear(volume_db), db_to_linear(target_volume_db), fade_duration)
	play()

func stop_playing():
	if not is_audio_playing:
		return
	
	should_loop = false
	var tween = get_tween()
	tween.tween_method(_set_volume, db_to_linear(volume_db), 0, fade_duration)
	tween.tween_callback(_on_music_finished)

func set_target_volume(target_volume: float) -> void:
	target_volume_db = target_volume

func set_track(_stream: AudioStream) -> void:
	stream = _stream

func _ready() -> void:
	connect("finished", _on_music_finished)
	if target_volume_db == null:
		target_volume_db = 0

func _set_volume(volume: float) -> void:
	volume_db = linear_to_db(volume)

func _on_music_finished() -> void:
	if should_loop:
		play()
	else:
		is_audio_playing = false

func get_tween() -> Tween:
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	return tween
