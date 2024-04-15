extends Node

func start_game() -> void:
	MusicPlayer.stop_playing()
	var hidden = TransitionManager.fade_to_black() as Signal
	if not hidden.is_null():
		await hidden
	
	get_tree().change_scene_to_file("res://Level/prelude.tscn")

func quit_game() -> void:
	match OS.get_name():
		"Web":
			MusicPlayer.stop_playing()
			await MusicPlayer.stopped_playing
			get_tree().paused = true
			OS.alert("Please close the tab.")
		_:
			get_tree().quit()

func reset_game() -> void:
	DialogueManager.reset()

func quit_to_menu() -> void:
	GameManager.reset_game()
	var hidden = TransitionManager.fade_to_black() as Signal
	if not hidden.is_null():
		await hidden
	get_tree().change_scene_to_file("res://Menus/start_menu.tscn")
