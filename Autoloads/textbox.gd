extends CanvasLayer

@onready var label = %Words
@onready var speaker = %Name
@onready var timer = $LetterDisplayTimer
@onready var container = $Container
@onready var choices = $ChoiceLayer
@onready var dramatic_pause = $DramaticPauseTimer
@export var audio_track: AudioStream = preload ("res://Assets/SFX/single_vowel.wav")

var dialogue_lines: Dialogue
var current_line_index = 0
var is_dialogue_active = false
var can_advance_line = false

var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal scripted_event(event: String)
signal talk(isTalking: bool, person: String)

func _ready() -> void:
	container.hide()

func set_voice(voice: AudioStream):
	audio_track = voice

# takes in a Dialogue to process
func start_dialogue(lines: Dialogue) -> void:
	if lines.lines.size() == 0 and lines.end_choice_pointer.is_empty():
		print('Dialogue started incorrectly')
		return
	
	if self.visible == false:
		self.show()
	if container.visible == false:
		container.show()
	
	dialogue_lines = lines
	
	#print(dialogue_lines.lines[0].message)
	current_line_index = 0
	is_dialogue_active = true
	can_advance_line = false
	show_line()

# display text message in textbox along with the speaker's name
func display_text(person: String, text_to_display: String) -> void:
	text = text_to_display
	speaker.text = person
	talk_emitter(true)
	label.text = ""
	display_letter()

# display one letter of message at a time
func display_letter() -> void:
	label.text += text[letter_index]
	letter_index += 1
	
	if letter_index >= text.length():
		talk_emitter(false)
		can_advance_line = true
		letter_index = 0
		return
	
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
			
			var pitch = randf_range(0.9, 1.1)
			if text[letter_index] in ["a", "e", "i", "o", "u"]:
				pitch += 0.2
			SoundPlayer.play_sound(audio_track, pitch)

# when timer runs out, display next letter of message
func _on_letter_display_timer_timeout() -> void:
	display_letter()

# call display_text() for current line. If speaker is "EVENT", emit scripted_event and hanlde next line.
func show_line() -> void:
	while dialogue_lines.lines[current_line_index].speaker == "EVENT":
		print("EVENT: " + dialogue_lines.lines[current_line_index].message)
		
		#EVENT PAUSE_[some number] triggers a dramatic pause for that amount of seconds
		if dialogue_lines.lines[current_line_index].message.contains("PAUSE"):
			container.hide()
			can_advance_line = false
			var time = int(dialogue_lines.lines[current_line_index].message.substr(6))
			dramatic_pause.start(time)
			await dramatic_pause.timeout
		else:
			handle_scripted_event(dialogue_lines.lines[current_line_index].message)
		
		current_line_index += 1
		if current_line_index >= dialogue_lines.lines.size():
			finish_dialogue()
			return

	display_text(dialogue_lines.lines[current_line_index].speaker, dialogue_lines.lines[current_line_index].message)
	can_advance_line = false

# emit signal scripted_event, containing event type (such as "strike" or "restore")
func handle_scripted_event(event: String) -> void:
	scripted_event.emit(event)

# when clicking "proceed" button, move to next line if possible.
# when at end of dialogue, check for new dialogue to process at end_choice_pointer
# if multiple dialogue choices, spawn choice buttons
# if one dialogue choice, just start processing that dialogue
func _unhandled_input(event) -> void:
	if event.is_action_pressed("proceed") and can_advance_line and is_dialogue_active:
		current_line_index += 1
		if current_line_index >= dialogue_lines.lines.size():
			finish_dialogue()
			return
			
		show_line()

func finish_dialogue() -> void:
	is_dialogue_active = false
	current_line_index = 0
	container.hide()
	
	if dialogue_lines.end_choice_pointer.is_empty():
		return

	if dialogue_lines.end_choice_pointer.size() > 1:
		var words = dialogue_lines.end_choice_lines
		var pointers = dialogue_lines.end_choice_pointer
		choices.display_choices(words, pointers)
	else:
		start_dialogue(dialogue_lines.end_choice_pointer[0])

func reset() -> void:
	hide()
	current_line_index = dialogue_lines.lines.size()
	choices.clear_button()

func _on_dramatic_pause_timer_timeout() -> void:
	if current_line_index < dialogue_lines.lines.size() - 1:
		print('show')
		container.show()

func talk_emitter(isTalking: bool) -> void:
	talk.emit(isTalking, speaker.text)
