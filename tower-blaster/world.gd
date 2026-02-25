extends Node3D

@onready var ui: Control = $UI
@onready var player: Player = $Player
@onready var base: Base = $Base

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if base.win:#start here
		ui.win = true
		gameWin()

func gameOver()->void:
	if ui.timeOut or ui.loss:
		player.playing = false

func gameWin()->void:
	if ui.win:
		player.playing = false #.alive = false
		for obj in get_tree().get_nodes_in_group("turets"):
			obj.alive = false
