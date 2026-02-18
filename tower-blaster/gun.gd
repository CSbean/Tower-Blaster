extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func play(str : String)->void:
	animation_player.play(str)
