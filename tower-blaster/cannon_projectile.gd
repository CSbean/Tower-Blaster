extends Area3D

@onready var timer: Timer = $Timer

var direction := Vector3.FORWARD

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	global_position += direction * delta * 2


func _on_timer_timeout() -> void:
	queue_free()
