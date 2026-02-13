extends Node3D
class_name Base

@onready var progress_bar: ProgressBar = $Sprite3D/SubViewport/ProgressBar


var health = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(num : float)->void:
	health -= num
	#https://www.youtube.com/watch?v=Afq4P6sS-xY
	if progress_bar.value < num:
		num = progress_bar.value
	print(health)
