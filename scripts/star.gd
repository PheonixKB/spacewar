extends Area2D

# Strength of gravity
@export var gravity_strength: float = 500000.0

# Minimum distance to prevent infinite force
@export var min_distance: float = 50.0

# Bodies currently inside gravity field
var bodies: Array[CharacterBody2D] = []


func _ready():

	# Connect signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _physics_process(delta):

	# Apply gravity to every body inside field
	for body in bodies:

		# Skip deleted objects
		if !is_instance_valid(body):
			continue

		var direction = global_position - body.global_position
		var distance = max(direction.length(), min_distance)

		# Inverse-square gravity
		var acceleration = gravity_strength / (distance * distance)

		# Accelerate body toward star
		body.velocity += direction.normalized() * acceleration * delta


func _on_body_entered(body):

	# Add CharacterBody2D to gravity list
	if body is CharacterBody2D:
		bodies.append(body)


func _on_body_exited(body):

	# Remove body when it leaves gravity field
	if body is CharacterBody2D:
		bodies.erase(body)
