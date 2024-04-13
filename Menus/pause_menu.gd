extends CanvasLayer

@onready var start = preload("res://Menus/start_menu.tscn")
@onready var options = $OptionsMenu
@onready var menu = $Menu
var paused

func _ready():
	hide()
	paused = false
	
func pauseMenu():
	if paused:
		hide()
		get_tree().paused = false
	else:
		show()
		get_tree().paused = true
	paused = !paused
	
func _on_resume_pressed():
	pauseMenu()


func _on_options_pressed():
	options.show()
	menu.hide()


func back_button():
	menu.show()
	options.hide()
	
func _input(_event):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
