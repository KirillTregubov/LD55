extends Node

func start_game() -> void:
	MusicPlayer.stop_playing()
	var hidden = TransitionManager.fade_to_black() as Signal
	if not hidden.is_null():
		await hidden
	
	get_tree().change_scene_to_file("res://Level/prelude.tscn")

func quit_game() -> void:
	get_tree().quit()

func reset_game() -> void:
	DialogueManager.reset()
