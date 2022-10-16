extends Node

var elapsed = 0

var player_template: = preload("res://scenes/actors/player/player.tscn")
var controller_players : Dictionary = {}
var keyboard_player: Player = null
var player_id: int = 0


# `pre_start()` is called when a scene is loaded.
# Use this function to receive params from `Game.change_scene(params)`.
func pre_start(params):
	var cur_scene: Node = get_tree().current_scene
	print("Current scene is: ", cur_scene.name, " (", cur_scene.filename, ")")
	print("gameplay.gd: pre_start() called with params = ")
	if params:
		for key in params:
			var val = params[key]
			printt("", key, val)

	print("Processing...")
	$TileMap2.modulate = Globals.color_palette[Globals.COLOR.WHITE] #asdghASg NOT WOOORKING
	$TileMap.modulate = Globals.color_palette[Globals.COLOR.WHITE] #asdghASg NOT WOOORKING

	print("Done")
	


# `start()` is called when the graphic transition ends.
func start():
	print("gameplay.gd: start() called")
	
	print("Controllers management:")
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
	
	for id in Input.get_connected_joypads().size():
		print("Controller: %s, id: %s" % [Input.get_joy_name(id), id]) 


func _on_joy_connection_changed(device: int, connected: bool) -> void:
	print("Joy connection changed: device - %s, connected: - %s" % [device, connected])


func _input(event):
	if event is InputEventJoypadButton:
		if event.pressed and not is_instance_valid(controller_players.get(event.device)):
			controller_players[event.device] = spawn_player("c%s" % event.device)
			
	if event is InputEventKey and not is_instance_valid(keyboard_player):
		if event.pressed:
			keyboard_player = spawn_player('k')


func spawn_player(device_id) -> Player:
	var player = player_template.instance()
	player.player_id = device_id
	$Players.add_child(player)
	return player

	


