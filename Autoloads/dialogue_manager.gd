extends Node

var dialogue_lines: Array[String] = []
var speaker: String
var current_line_index = 0

var is_dialogue_active = false
var can_advance_line = false

func start_dialogue(person: String, lines: Array[String]):
	if is_dialogue_active:
		return
		
	speaker = person
	dialogue_lines = lines
	
	show_line()
	is_dialogue_active = true
	
func show_line():
	pass
