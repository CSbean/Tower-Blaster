extends Area3D


@onready var timer: Timer = $Timer


@export var speed : int

var direction := Vector3.FORWARD
var parry = false

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
	

func reverse_direction(collision_vector:Vector3)->void:
	direction = direction.bounce(collision_vector)

func parryed()->void:
	speed = speed*2
	parry = true


func _on_area_entered(area: Area3D) -> void:
	if area.get_parent() is Turret:
		area.get_parent().take_damage()
	if area.get_parent() is Base:
		area.get_parent().take_damage(15)
