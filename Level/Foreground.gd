extends CanvasLayer

@export var pleased = preload("res://Assets/SFX/crowd_pleased.wav")
@export var surprised = preload("res://Assets/SFX/crowd_surprise.wav")

func crowd_pleased():
	SoundPlayer.play_sound(pleased)
	
func crowd_surprised():
	SoundPlayer.play_sound(surprised)
