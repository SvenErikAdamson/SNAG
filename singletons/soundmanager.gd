extends Node


const CLICK = preload("res://assets/audio/sounds/click.wav")
const TILL = preload("res://assets/audio/sounds/till.wav")
const DROP =preload("res://assets/audio/sounds/drop.wav")
const BLIP = preload("res://assets/audio/sounds/blip.wav")
@onready var EffectsPlayer = $EffectsPlayer


func play_sound(sound):
	for audio_player in  EffectsPlayer.get_children():
		if not audio_player.playing:
				audio_player.stream = sound
				audio_player.play()
				break
		
