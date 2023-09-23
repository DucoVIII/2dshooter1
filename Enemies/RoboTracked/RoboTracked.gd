extends Node2D
var playerposition = Globals.playerposition
var movetarget
var sleeping
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("walk")
	movetarget = position
	sleeping = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sleeping == false:
		rotation = Globals.playerrotation
		if position != movetarget:
			#move to target
			var speed = 200
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
