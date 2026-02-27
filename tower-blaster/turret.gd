extends Node3D
class_name Turret

@onready var turret_bace: Node3D = $turretBace
@onready var player: Player = $"../Player"
@onready var cannon: Node3D = $turretBace/turretTop/Cannon
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $Area3D2/CollisionShape3D


@export var rangeX = 20
@export var rangeZ = 20
@export var color:Color=Color.INDIAN_RED
var proj = preload("res://cannon_projectile.tscn")
var health = 100
var alive = true
var playerInRange = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var range_box := BoxShape3D.new()
	range_box.size=Vector3(rangeX,5,rangeZ)
	collision_shape_3d.shape = range_box
	collision_shape_3d.debug_color=color
	print(name,collision_shape_3d.shape.size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if health > 0:
		turret_bace.look_at(player.global_position, Vector3.UP, true)
		turret_bace.rotation.x = 0
	


func _on_timer_timeout() -> void:
	if health > 0 and playerInRange:
		var new_proj = proj.instantiate()
		add_child(new_proj)
		new_proj.global_position = cannon.global_position
		new_proj.global_position.y += 1
		new_proj.direction = new_proj.global_position.direction_to(player.global_position)
		animation_player.play("shoot")


func take_damage()->void:
	if alive:
		alive = false
		health = 0
		cannon.rotate_x(-30.0)
		player.score+=20
		#create_tween()

func game_end()->void:
	if alive:
		alive = false
		health = 0
		cannon.rotate_x(-30.0)

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body is Player:
		playerInRange = true
	

func _on_area_3d_2_body_exited(body: Node3D) -> void:
	if body is Player:
		playerInRange = false
