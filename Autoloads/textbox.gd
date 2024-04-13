extends CanvasLayer

@onready var label = %Words
@onready var speaker = %Name
@onready var timer = $LetterDisplayTimer
@onready var container = $Container
@onready var choices = $ChoiceLayer

var dialogue_lines: Dialogue
var current_line_index = 0
var is_dialogue_active = false
var can_advance_line = false

var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal scripted_event(event:String)

func _ready():
	container.hide()
	
# display text message in textbox along with the speaker's name
func display_text(person: String, text_to_display: String):
	text = text_to_display
	speaker.text = person
	label.text = ""
	display_letter()
	
# display one letter of message at a time
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
	
# when timer runs out, display next letter of message
func _on_letter_display_timer_timeout():
	display_letter()

# takes in a Dialogue to process
func start_dialogue(lines: Dialogue):
	if is_dialogue_active:
		return
	
	if container.visible == false:
		container.show()

	dialogue_lines = lines
	show_line()
	is_dialogue_active = true
	
# call display_text() for current line. If speaker is "EVENT", emit scripted_event and hanlde next line.
func show_line():
	if dialogue_lines.lines[current_line_index].speaker == "EVENT":
		handle_scripted_event(dialogue_lines.lines[current_line_index].message)
		current_line_index += 1
		
	display_text(dialogue_lines.lines[current_line_index].speaker, dialogue_lines.lines[current_line_index].message)
	can_advance_line = false
	
# emit signal scripted_event, containing event type (such as "strike" or "restore")
func handle_scripted_event(event : String):
	scripted_event.emit(event)
	
# when clicking "proceed" button, move to next line if possible.
# when at end of dialogue, check for new dialogue to process at end_choice_pointer
# if multiple dialogue choices, spawn choice buttons
# if one dialogue choice, just start processing that dialogue
func _unhandled_input(event):
	if event.is_action_pressed("proceed") && can_advance_line && is_dialogue_active:
		current_line_index += 1
		if current_line_index >= dialogue_lines.lines.size():
			is_dialogue_active = false
			current_line_index = 0
			container.hide()
			
			if !dialogue_lines.end_choice_pointer.is_empty():
				if dialogue_lines.end_choice_pointer.size() > 1:
					var words = dialogue_lines.end_choice_lines
					var pointers = dialogue_lines.end_choice_pointer
					choices.display_choices(words, pointers)
				else:
					start_dialogue(dialogue_lines.end_choice_pointer[0])
			return
		show_line()
