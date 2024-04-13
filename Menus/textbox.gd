extends CanvasLayer

@onready var label = %Words
@onready var speaker = %Name
@onready var timer = $MarginContainer/VBoxContainer/VBoxContainer/Textbox/LetterDisplayTimer

var dialogue_lines: Array[String] = []
var current_line_index = 0
var is_dialogue_active = false
var can_advance_line = false

var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

func _ready():
	hide()
	
func display_text(text_to_display: String):
	text = text_to_display
	label.text = ""
	display_letter()
	
func display_letter():
	label.text += text[letter_index]
	letter_index += 1
	
	if letter_index >= text.length():
		can_advance_line = true
		letter_index=0
		return
		
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
			
func _on_letter_display_timer_timeout():
	display_letter()

func start_dialogue(person: String, lines: Array[String]):
	if is_dialogue_active:
		return
	
	if visible == false:
		show()
	speaker.text = person
	dialogue_lines = lines
	
	show_line()
	is_dialogue_active = true
	
func show_line():
	display_text(dialogue_lines[current_line_index])
	can_advance_line = false
	
func _unhandled_input(event):
	if event.is_action_pressed("proceed") && can_advance_line && is_dialogue_active:
		current_line_index += 1
		if current_line_index >= dialogue_lines.size():
			is_dialogue_active = false
			current_line_index = 0
			hide()
			return
		show_line()
	
