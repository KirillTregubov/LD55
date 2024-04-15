extends CanvasLayer

enum Witness {Abaddon, Bug, Chester, Mosquito}
var current_witness: Witness

@onready var background = $Background
@onready var bug = $Bug
@onready var chester = $Chester
@onready var abaddon = $Abaddon
@onready var mosquito = $Mosquito

func _ready():
	DialogueManager.scripted_event.connect(handle_events)
	DialogueManager.talk.connect(talk)
	background.visible = false
	bug.visible = false
	chester.visible = false
	abaddon.visible = false
	mosquito.visible = false
	
func handle_events(event: String):
	match event:
		"bug_appear":
			bug_appear()
		"chester_appear":
			chester_appear()
		"abaddon_appear":
			abaddon_appear()
		"mosquito_appear":
			mosquito_appear()
		"disappear":
			witness_visiblity(false)
	
func witness_visiblity(seen: bool):
	$Background.visible = seen
	match current_witness:
		Witness.Bug:
			bug.visible = seen
		Witness.Chester:
			chester.visible = seen
		Witness.Abaddon:
			abaddon.visible = seen	
		Witness.Mosquito:
			mosquito.visible = seen	

func talk(isTalking: bool, person: String):
	match person:
		"Bug":
			if isTalking:
				bug.play("talking")
			else:
				bug.play("default")
		"Chester":
			if isTalking:
				chester.play("talking")
			else:
				chester.play("default")
		"Abaddon":
			if isTalking:
				abaddon.play("talking")
			else:
				abaddon.play("default")
		"Mosquito":
			if isTalking:
				mosquito.play("talking")
			else:
				mosquito.play("default")

func bug_appear():
	current_witness = Witness.Bug
	witness_visiblity(true)
	
func chester_appear():
	current_witness = Witness.Chester
	witness_visiblity(true)
	
func abaddon_appear():
	current_witness = Witness.Abaddon
	witness_visiblity(true)
	
func mosquito_appear():
	current_witness = Witness.Mosquito
	witness_visiblity(true)
