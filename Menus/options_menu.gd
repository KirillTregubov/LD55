extends CanvasLayer

@onready var main = $"../"

func _on_back_button_pressed():
	main.back_button()
