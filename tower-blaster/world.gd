extends Node3D

@onready var ui: Control = $UI
@onready var player: Player = $Player
@onready var base: Base = $Base

var stoper = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if base.win and stoper == 0:
		ui.win = true
		stoper += 1
		gameWin()
	ui.update_score(player.score)

func gameOver()->void:
	if ui.timeOut or ui.loss:
		GameMangager.playing = false
		player.change_mouse()

func gameWin()->void:
	if ui.win:
		GameMangager.playing = false #.alive = false
		player.change_mouse()
		for obj in get_tree().get_nodes_in_group("turets"):
			obj.game_end()
