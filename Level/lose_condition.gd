extends Node2D

@export var opening: Dialogue
@onready var pause_menu = $PauseMenu
@onready var animation = $AnimationPlayer
@onready var judge = $Subjects/Judge

@onready var defendant = $Subjects/Defendant
func _ready():
	DialogueManager.scripted_event.connect(handle_scripted_events)
	DialogueManager.start_dialogue(opening)
	defendant.visible = true
	defendant.position = Vector2(960,710)

func handle_scripted_events(event: String):
	match event:
		"eat":
			judge.mouth_open()
			animation.play("eat")
		"dead":
			pause_menu.queue_free()
			$DeathScreen.dead()


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"eat":
			judge.mouth_close()
