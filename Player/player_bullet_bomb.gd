extends Node2D

var explode = preload("res://Effects/explosion.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(delta * 400)
	pass




func _on_area_2d_area_entered(area):
	#if(area.get_collision_layer_bit(2)):
		_delete_bullet()


func _delete_bullet():
	var explosion_instance = explode.instantiate()
	explosion_instance.position = get_global_position()
	get_tree().get_root().add_child(explosion_instance)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	_delete_bullet()

