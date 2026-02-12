extends Node3D
class_name Turret

@onready var turret_bace: Node3D = $turretBace
@onready var player: Player = $"../Player"
@onready var cannon: Node3D = $turretBace/turretTop/Cannon
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var proj = preload("res://cannon_projectile.tscn")
var health = 100000000000
var alive = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if health > 0:
		turret_bace.look_at(player.global_position, Vector3.UP, true)
		turret_bace.rotation.x = 0
	


func _on_timer_timeout() -> void:
	if health > 0:
		var new_proj = proj.instantiate()
		add_child(new_proj)
		new_proj.global_position = cannon.global_position
		new_proj.global_position.y += 1
		new_proj.direction = new_proj.global_position.direction_to(player.global_position)
		animation_player.play("shoot")


func take_damage()->void:
	if alive:
		#alive = false
		#health = 10
		cannon.rotate_x(-30.0)
		create_tween()
