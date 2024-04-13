extends Button

var lines: Dialogue

func _on_pressed():
	DialogueManager.start_dialogue(lines)
