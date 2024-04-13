extends CanvasLayer

@onready var options_menu = $OptionsMenu
@onready var title = $TitleMenuContainer

func _on_options_pressed():
	title.hide()
	options_menu.show()

func back_button():
	title.show()
	options_menu.hide()
