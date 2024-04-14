extends CanvasLayer

@onready var title = $TitleMenuContainer
@onready var music = $music

func _ready():
	music.play()
	OptionsMenu.exit.connect(back_button)
	
func _on_options_pressed() -> void:
	title.hide()
	OptionsMenu.show()

func back_button() -> void:
	title.show()
	OptionsMenu.hide()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Level/court_case.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()


func _on_music_finished():
	music.play()
