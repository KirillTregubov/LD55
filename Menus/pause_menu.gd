extends CanvasLayer

@onready var start = preload("res://Menus/start_menu.tscn")
@onready var bg = $ColorRect
@onready var options = $OptionsMenu
@onready var menu = $Menu
@onready var button = $PauseButton
var paused: bool
var pauseActions = null

func _ready():
	#hide()
	bg.hide()
	menu.hide()
	paused = false


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
	pauseMenu()


func _on_options_pressed():
	pauseActions = InputMap.action_get_events("pause")
	InputMap.action_erase_events("pause")
	options.show()
	menu.hide()


func back_button():
	if pauseActions != null:
		for event in pauseActions:
			InputMap.action_add_event("pause", event)
	menu.show()
	options.hide()


func _input(_event):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()


func _on_quit_pressed():
	await pauseMenu()
	DialogueManager.hide()
	get_tree().change_scene_to_file("res://Menus/start_menu.tscn")


func _on_button_pressed() -> void:
	pauseMenu()
