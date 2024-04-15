extends Node2D

@export var opening: Dialogue
@onready var pause_menu = $PauseMenu
func _ready():
	DialogueManager.scripted_event.connect(handle_scripted_events)
	DialogueManager.start_dialogue(opening)

func handle_scripted_events(event: String):
	match event:
		"eat":
			print("Yum")
		"dead":
			pause_menu.queue_free()
			$DeathScreen.dead()
