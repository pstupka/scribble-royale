extends Node

var elapsed = 0


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
	print("Processing...")
	yield(get_tree().create_timer(2), "timeout")
	print("Done")


# `start()` is called when the graphic transition ends.
func start():
	print("gameplay.gd: start() called")
	print("Connected controllers:")
	for id in Input.get_connected_joypads().size():
		print("Controller: %s, id: %s" % [Input.get_joy_name(id), id]) 
