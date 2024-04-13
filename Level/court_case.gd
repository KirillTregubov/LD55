extends Node2D


const test_lines : Array[String] = [
	"Hey there!",
	"Listen",
	"We are in the middle of a test."
]

func _ready():
	DialogueManager.start_dialogue("Jaya", test_lines)
