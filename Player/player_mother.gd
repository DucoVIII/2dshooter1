extends Node2D

var speed = Globals.playerspeed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ROTATE_LEFT"):
		$PlayerCamera.rotation_degrees -= 2
	if Input.is_action_pressed("ROTATE_RIGHT"):
		$PlayerCamera.rotation_degrees += 2
	var camera_direction = $PlayerCamera.rotation
	var velocity = Vector2.ZERO
	var input_direction = Input.get_vector("PLAYER_LEFT", "PLAYER_RIGHT", "PLAYER_UP", "PLAYER_DOWN")
	var move_direction = input_direction.rotated(camera_direction)
	velocity = move_direction * speed
	position += velocity * delta



#
#	var velocity = Vector2.ZERO # The player's movement vector.
#	if Input.is_action_pressed(&"PLAYER_RIGHT"):
#		velocity.x += 1
#	if Input.is_action_pressed(&"PLAYER_LEFT"):
#		velocity.x -= 1
#	if Input.is_action_pressed(&"PLAYER_DOWN"):
#		velocity.y += 1
#	if Input.is_action_pressed(&"PLAYER_UP"):
#		velocity.y -= 1
#	if velocity.length() > 0:
#		velocity = velocity.normalized() * speed
#	position += velocity * delta
#
