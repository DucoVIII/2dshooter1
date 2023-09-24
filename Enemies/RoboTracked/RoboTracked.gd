extends Node2D
var playerposition = Globals.playerposition
var movetarget
var sleeping
var speed = Globals.robotrackedSpeed
var explode = preload("res://Effects/explosion.tscn")
var health = Globals.robotrackedHealth
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("walk")
	movetarget = position
	sleeping = true
	health = Globals.robotrackedHealth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	rotation = Globals.playerrotation
	if sleeping == false:
		#hmm dit is niet hoe dit hoort te werken
		var movetargetwiggle = Vector2(0.1, 0.1)
		movetargetwiggle.rotated((movetarget - position).angle())
		if (movetarget - position) < movetargetwiggle:
			print("move")
		else:
			print("shake")
		if position != movetarget:
			#move to target
			var move_direction = movetarget - position
			move_direction = move_direction.normalized()
			var velocity = move_direction * speed
			position += velocity * delta




func _on_wander_timer_timeout():
	#set a random delay until the next movement
	var wanderdelay = randi() % 20 + 10
	$WanderTimer.wait_time = wanderdelay / 10
	#flip a coin to see where to go
	var coinflip = randi_range(0, 1)
	if coinflip == 1:
		#set move target to player
		playerposition = Globals.playerposition
		movetarget = playerposition - position
	if coinflip == 0:
		#set move target in a random direction
		var wandertarget_degrees = randi_range(0, 365)
		var wandertarget = Vector2.from_angle(wandertarget_degrees)
		movetarget = wandertarget.normalized()




# hitboxes plis merk elkaar op
func _on_vision_range_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	sleeping = false


func _on_vision_range_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	sleeping = true


func _on_vision_range_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sleeping = false


func _on_vision_range_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sleeping = true


func _on_hitbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	health -= DamageCalc.enemy_take_damage(area)
	print(health)
	#health -= 1
	if health <= 0:
		var explosion_instance = explode.instantiate()
		explosion_instance.position = get_global_position()
		get_tree().get_root().add_child(explosion_instance)
		queue_free()
