extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$PlayerCamera.position = $PlayerRoot.position
	
	if Input.is_action_pressed("ROTATE_LEFT"):
		$PlayerCamera.rotation_degrees -= 2
	if Input.is_action_pressed("ROTATE_RIGHT"):
		$PlayerCamera.rotation_degrees += 2
