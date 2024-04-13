extends CanvasLayer

@onready var options_menu = $OptionsMenu
@onready var title = $TitleMenuContainer
@onready var game = preload("res://Level/court_case.tscn")

func _on_options_pressed():
	title.hide()
	options_menu.show()

func back_button():
	title.show()
	options_menu.hide()

func _on_start_pressed():
	get_tree().change_scene_to_packed(game)
