extends Panel
class_name Strike

@onready var sprite = $Sprite

func set_used() -> void:
	sprite.frame = 1

func reset() -> void:
	sprite.frame = 0

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
