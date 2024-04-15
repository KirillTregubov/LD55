extends CanvasLayer

@onready var start = preload ("res://Menus/start_menu.tscn")
@onready var bg = $Background
@onready var menu = $Menu
@onready var button = $PauseButton
var paused: bool
var pauseActions = null

func _ready():
	#hide()
	bg.hide()
	menu.hide()
	paused = false
	OptionsMenu.exit.connect(back_button)

func pauseMenu():
	if paused:
		button.show()
		bg.hide()
		menu.hide()
		get_tree().paused = false
	else:
		button.hide()
		bg.show()
		menu.show()
		get_tree().paused = true
	paused = !paused

func _on_resume_pressed():
	SoundPlayer.play_button_sound()
	pauseMenu()

func _on_options_pressed():
	SoundPlayer.play_button_sound()
	pauseActions = InputMap.action_get_events("pause")
	InputMap.action_erase_events("pause")
	OptionsMenu.show()
	menu.hide()

func back_button():
	if pauseActions != null:
		for event in pauseActions:
			InputMap.action_add_event("pause", event)
	menu.show()
	OptionsMenu.hide()

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func _on_quit_pressed():
	SoundPlayer.play_select_sound()
	GameManager.reset_game()
	var hidden = TransitionManager.fade_to_black() as Signal
	await pauseMenu()
	button.hide()
	if not hidden.is_null():
		await hidden
	get_tree().change_scene_to_file("res://Menus/start_menu.tscn")

func _on_button_pressed() -> void:
	SoundPlayer.play_button_sound()
	pauseMenu()
