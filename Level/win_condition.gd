extends Node2D
@export var opening: Dialogue
@onready var pause_menu = $PauseMenu
@onready var judge = $Subjects/Judge

@onready var defendant = $Subjects/Defendant

func _ready():
	DialogueManager.scripted_event.connect(handle_scripted_events)
	DialogueManager.start_dialogue(opening)
	defendant.visible = true
	defendant.position = Vector2(960,710)

func handle_scripted_events(event: String):
	match event:
		"vanish":
			defendant.visible = false
		"win":
			pause_menu.queue_free()
			$Win.win()
