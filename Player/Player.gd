extends Node2D

var speed = Globals.playerspeed
@export var bullet_speed = 500
var screen_size
var bulletbomb = preload("res://Player/player_bullet_bomb.tscn")
var playerrof = Globals.playerrof

signal playerhit
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$FireCooldown.wait_time = playerrof
	
	look_at(get_global_mouse_position())
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed(&"PLAYER_RIGHT"):
		velocity.x += 1
	if Input.is_action_pressed(&"PLAYER_LEFT"):
		velocity.x -= 1
	if Input.is_action_pressed(&"PLAYER_DOWN"):
		velocity.y += 1
	if Input.is_action_pressed(&"PLAYER_UP"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
#	position = position.clamp(Vector2.ZERO, screen_size)
	if Input.is_action_just_pressed("PLAYER_SHOOT"):
		$FireCooldown.start()
		_on_fire_cooldown_timeout()
	if Input.is_action_just_released("PLAYER_SHOOT"):
		$FireCooldown.stop()


func _on_area_2d_body_entered(body):
	playerhit.emit()


func _on_fire_cooldown_timeout():
#spawn bullet
	var bullet_instance = bulletbomb.instantiate()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	get_tree().get_root().add_child(bullet_instance)
