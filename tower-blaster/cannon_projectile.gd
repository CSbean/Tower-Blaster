extends Area3D

@onready var timer: Timer = $Timer
@onready var player: Player = $Player

@export var speed : int

var direction := Vector3.FORWARD


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position += direction * delta * speed


func _on_timer_timeout() -> void:
	queue_free()



func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.take_damage()
		queue_free()
