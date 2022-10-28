extends Control

onready var menu_background = get_node("%ColorRect")


func _ready():
	randomize()
	$Version/GameVersion.text = ProjectSettings.get_setting("application/config/version")
	$Version/GodotVersion.text = "Godot %s" % Engine.get_version_info().string
	# needed for gamepads to work
	$VBoxContainer/PlayButton.grab_focus()
	
	menu_background.color = Globals.color_palette[Globals.COLOR.DEFAULT]
	
	$VBoxContainer.modulate = Globals.color_palette[Globals.COLOR.WHITE]
	$CenterContainer.modulate = Globals.color_palette[Globals.COLOR.WHITE]
	$Version.modulate = Globals.color_palette[Globals.COLOR.WHITE]
	$Credits.modulate = Globals.color_palette[Globals.COLOR.WHITE]
	
	if OS.has_feature('HTML5'):
		$VBoxContainer/ExitButton.queue_free()


func _on_PlayButton_pressed() -> void:
	var params = {
		show_progress_bar = true,
		"a_number": 10,
		"a_string": "Ciao mamma!",
		"an_array": [1, 2, 3, 4],
		"a_dict": {
			"name": "test",
			"val": 15
		},
	}
	Game.change_scene("res://scenes/gameplay/gameplay.tscn", params)


func _on_SettingsButton_pressed() -> void:
	pass # Replace with function body.


func _on_ExitButton_pressed() -> void:
	# gently shutdown the game
	var transitions = get_node_or_null("/root/Transitions")
	if transitions:
		transitions.fade_in({
			'show_progress_bar': false
		})
		yield(transitions.anim, "animation_finished")
		yield(get_tree().create_timer(0.3), "timeout")
	get_tree().quit()
