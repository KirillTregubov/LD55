extends CanvasLayer
class_name StrikeDisplay

@onready var Strike = preload ("res://Level/Strikes/strike.tscn")
@onready var container: HBoxContainer = $MarginContainer/Container
@export var NUM_STRIKES: int = 3

var current_strike: int

# TODO: connect to manager
func handle_strike() -> void:
	if current_strike > container.get_child_count() - 1:
		return
	container.get_child(current_strike).set_used()
	current_strike += 1

# TODO: remove
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("test"):
		handle_strike()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(NUM_STRIKES > 0)
	current_strike = 0
	for i in range(NUM_STRIKES):
		var strike = Strike.instantiate()
		container.add_child(strike)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
