extends CharacterBody2D

@export var thrust := 100.0
@export var reverse_thrust := 70.0
@export var rotation_speed := 30.0
@export var max_speed := 800.0
@export var wrap_margin := 20.0
var screen_size: Vector2

func _ready():
	# Store viewport size for screen wrapping
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:

	# Rotate left
	if Input.is_action_pressed("rotate_left"):
		rotation_degrees -= rotation_speed * delta

	# Rotate right
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees += rotation_speed * delta

	# Forward direction of ship
	var forward = Vector2.UP.rotated(rotation)

	# Forward thrust
	if Input.is_action_pressed("forward_thrust"):
		velocity += forward * thrust * delta

	# Reverse thrust
	if Input.is_action_pressed("reverse_thrust"):
		velocity -= forward * reverse_thrust * delta

	# Clamp maximum speed
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed

	move_and_slide()
	wrap_screen()

func wrap_screen():

	if global_position.x < -wrap_margin:
		global_position.x = screen_size.x + wrap_margin
	elif global_position.x > screen_size.x + wrap_margin:
		global_position.x = -wrap_margin

	if global_position.y < -wrap_margin:
		global_position.y = screen_size.y + wrap_margin
	elif global_position.y > screen_size.y + wrap_margin:
		global_position.y = -wrap_margin
