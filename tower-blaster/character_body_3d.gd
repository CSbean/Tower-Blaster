extends CharacterBody3D
class_name Player

# https://www.youtube.com/watch?v=fAVetlIROXM
var SPEED = 5.0 #5.0
const JUMP_VELOCITY = 3
#finish the game Over signal in world
@onready var camera_3d: Camera3D = $Camera3D
@onready var ray_cast_3d: RayCast3D = $Camera3D/RayCast3D
@onready var ui: Control = $"../UI"
@onready var marker_3d: Marker3D = $Marker3D
@onready var gun: Node3D = $gun

@export var health := 100

var look_dir: Vector2
var camra_sense := 50
var capMouse := false
var sprinting = false
var playing = true

func _ready() -> void:
	change_mouse()


func _process(_delta: float) -> void:
	if playing:
		if Input.is_action_just_pressed("shoot"):
			gun.play("shoot")
			if ray_cast_3d.is_colliding():
				if ray_cast_3d.get_collider() is Area3D:
					ray_cast_3d.get_collider().queue_free()
				if ray_cast_3d.get_collider().get_parent() is Base:
					ray_cast_3d.get_collider().get_parent().take_damage(0.5)
		if Input.is_action_just_pressed("sprint_toggle"):
			if not sprinting:
				sprinting = true
				SPEED = 50.0#15.0
				ui.sprint_toggle()
			else:
				sprinting = false
				SPEED = 5.0
				ui.sprint_toggle()
		#projectile.direction = (ray.target_position - ray.global_position).normalized()
		if Input.is_action_just_pressed("melee"):
			if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider() is Area3D:
				var dist = ray_cast_3d.get_collision_point().distance_to(global_position)
				if dist < 5:
					#ray_cast_3d.get_collider().reverse_direction(ray_cast_3d.get_collision_normal())
					#var global_dir = ($RayCast3D.to_global($RayCast3D.target_position) - $RayCast3D.global_position).normalized()
					#ray_cast_3d.get_collider().direction = ray_cast_3d.to_global((ray_cast_3d.target_position + ray_cast_3d.global_position)).normalized()
					#ray_cast_3d.get_collider().direction = to_global(rotation.normalized())
					#print(ray_cast_3d.target_position + ray_cast_3d.global_position)
					ray_cast_3d.get_collider().direction = global_position.direction_to(marker_3d.global_position)
					ray_cast_3d.get_collider().parryed()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_foward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if Input.is_action_just_pressed("pause"):
		change_mouse()
	
	rotate_camrea(delta)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion: 
		look_dir = event.relative * 0.01

func rotate_camrea(delta: float, sense_mod: float = 1.0):
	var input = Input.get_vector("ui_left","ui_right","ui_down","ui_up")
	look_dir += input
	rotation.y -= look_dir.x * camra_sense * delta
	camera_3d.rotation.x = clamp(camera_3d.rotation.x - look_dir.y * camra_sense * sense_mod * delta,-1.5, 1.5)
	look_dir = Vector2.ZERO

func take_damage()->void:
	health -= 5
	ui.update_health(health)

func change_mouse()->void:
	capMouse = !capMouse
	if capMouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
