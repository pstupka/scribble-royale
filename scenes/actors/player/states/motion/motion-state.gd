class_name MotionState
extends State
# Collection of important methods to handle direction and animation.

func handle_input(event):
#	if event.is_action_pressed("simulate_damage"):
#		emit_signal("finished", "stagger")
	pass

func get_input_direction():
	var input_direction = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			0
	)
	return input_direction


func update_look_direction(direction):
	if direction and owner.look_direction != direction:
		owner.look_direction = direction