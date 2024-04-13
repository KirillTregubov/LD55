extends CanvasLayer

@onready var options_menu = $OptionsMenu
@onready var title = $TitleMenuContainer

func _on_options_pressed() -> void:
	title.hide()
	options_menu.show()

func back_button() -> void:
	title.show()
	options_menu.hide()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Level/court_case.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()
