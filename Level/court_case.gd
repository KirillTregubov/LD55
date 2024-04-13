extends Node2D

const test_lines: Array[String] = [
	"Hey there!",
	"Listen",
	"We are in the middle of a test."
]

func callback():
	print('callback')

func _ready():
	DialogueManager.start_dialogue("Jaya", test_lines)
	#DialogueManager.start_dialogue("Jaya", test_lines, callback)
