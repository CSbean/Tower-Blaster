extends Node3D
class_name Base

@onready var progress_bar: ProgressBar = $Sprite3D/SubViewport/ProgressBar
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles
@onready var player: Player = $"../Player"


var health = 100
var win = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(num : float)->void:
	health -= num
	if health <= 0:
		explode()
		win = true
		
	#https://www.youtube.com/watch?v=Afq4P6sS-xY
	if progress_bar.value < num:
		num = progress_bar.value
	progress_bar.value -= num


func explode()->void:
	player.score+= 1000
	GameMangager.playing = false
	progress_bar.visible = false
	explosion_particles.emitting = true
