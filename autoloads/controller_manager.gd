extends Node


func apply_input_map(player_id: int, device: int) -> void:
	var event
	var input_actions_template : Dictionary = {
		"move_left": "move_left_p%s" % player_id,
		"move_right": "move_right_p%s" % player_id,
		"move_up": "move_up_p%s" % player_id,
		"move_down": "move_down_p%s" % player_id,
		"jump": "jump_p%s" % player_id,
		"attack": "attack_p%s" % player_id,
		"secondary_attack": "secondary_attack_p%s" % player_id,
		"lock_move": "lock_move_p%s" % player_id,
	}
	event = InputEventJoypadButton.new()
	var move_left_p1 = {
		"deadzone": 0.2,
		"events": {
			"device":1,
			"axis":0,
			"axis_value":-1.0,
			"script":null
		}
	}


func register_player() -> int:
	return 0
