extends CharacterBody2D

# Player's speed (pixels/sec)
@export var speed: int = 300
# Size of the game window
@export var screen_size: Vector2
# Reference to the AnimatedSprite2D node
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Player's direction
var direction: String

func _ready():
	screen_size = get_viewport_rect().size
	
# Function to handle movement and animation
func _process(delta: float) -> void:
	velocity = Vector2.ZERO
	direction = ""
	
	# Check for input and adjust the velocity accordingly
	if Input.is_action_pressed("up") || Input.is_action_pressed("ui_up"):
		velocity.y = -1
		direction = "up"
	elif Input.is_action_pressed("down"):
		velocity.y = 1
		direction = "down"
	elif Input.is_action_pressed("left"):
		velocity.x = -1
		direction = "left"
	elif Input.is_action_pressed("right"):
		velocity.x = 1
		direction = "right"

	# If a direction is detected, play the corresponding animation
	if direction != "":
		animated_sprite.play(direction)
		velocity = velocity.normalized() * speed
	else:
		animated_sprite.stop()

	# Move the player
	move_and_slide()
		
	# Update the player's position to stay inside the screen boundaries	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

