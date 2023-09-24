extends Node
var damagetaken = 0
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func enemy_take_damage(shottype):
	shottype = shottype.to_string()
	var isBulletBomb = "BulletBomb"
	if isBulletBomb in shottype:
		damagetaken = Globals.playerBulletBombDamage
		return damagetaken

	else:
		damagetaken = 0
		return damagetaken

