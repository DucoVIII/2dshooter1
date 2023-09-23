extends Node2D

var speed = Globals.playerspeed
@export var bullet_speed = 500
var screen_size
var bulletbomb = preload("res://Player/player_bullet_bomb.tscn")
var playerrof = Globals.playerrof
var autofire

signal playerhit
# Called when the node enters the scene tree for the first time.
func _ready():
	autofire = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$FireCooldown.wait_time = playerrof
	#var mouse_pos = get_global_mouse_position()
	#look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("AUTOFIRE"):
		if autofire == false:
			autofire = true
		else:
			autofire = false
			$FireCooldown.stop()
	if autofire == true:
		if $FireCooldown.is_stopped():
			$FireCooldown.start()
	if autofire == false:
		if Input.is_action_just_pressed("PLAYER_SHOOT"):
			_on_fire_cooldown_timeout()
		if Input.is_action_just_pressed("PLAYER_SHOOT"):
			$FireCooldown.start()
		if Input.is_action_just_released("PLAYER_SHOOT"):
			$FireCooldown.stop()


func _on_area_2d_body_entered(body):
	playerhit.emit()


func _on_fire_cooldown_timeout():
#shooting time
	var bullet_instance = bulletbomb.instantiate()
	var mouse_angle_radians = get_angle_to(get_global_mouse_position()) #get angle to mouse
	var mouse_angle_vector2 = Vector2.from_angle(mouse_angle_radians) #convert to vector
	var bullet_angle_vector2 = mouse_angle_vector2.rotated(rotation) #rotate with camera angle
	var bullet_angle_radians = bullet_angle_vector2.angle() #convert back from vector to angle
	bullet_instance.position = get_global_position() #position bullet
	bullet_instance.rotation = bullet_angle_radians #rotate bulllet
	get_tree().get_root().add_child(bullet_instance) #spawn bullet

