extends Node3D

@onready var ui: Control = $UI
@onready var player: Player = $Player
@onready var base: Base = $Base

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if base.win:#start here
		ui.win = true
		gameWin()
	ui.update_score(player.score)

func gameOver()->void:
	if ui.timeOut or ui.loss:
		GameMangager.playing = false

func gameWin()->void:
	if ui.win:
		GameMangager.playing = false #.alive = false
		for obj in get_tree().get_nodes_in_group("turets"):
			obj.game_end()

#func parry_points()->void:
#	player.score+= 20
