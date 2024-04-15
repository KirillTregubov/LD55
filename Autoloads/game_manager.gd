extends Node

func start_game() -> void:
	MusicPlayer.stop_playing()
	get_tree().change_scene_to_file("res://Level/court_case.tscn")

func quit_game() -> void:
	get_tree().quit()

func reset_game() -> void:
	DialogueManager.reset()
