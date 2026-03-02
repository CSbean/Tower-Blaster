extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func play(str : String)->void:
	animation_player.play(str)
	audio_stream_player.play()
