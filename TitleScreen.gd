extends Control


func _ready():
	Globals.kills = 0
	Globals.currentStage = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_button_pressed():
	get_tree().quit()


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://GameScene.tscn")
