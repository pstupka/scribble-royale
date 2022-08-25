extends PlayerState

func enter(_msg := {}):
	player.get_node("AnimationPlayer").play("idle")
	player._velocity.y = -player.max_jump_velocity
#	if event.is_action_released("jump") and _velocity.y < -min_jump_velocity:
#		_velocity.y = -min_jump_velocity


func handle_input(event: InputEvent) -> void:
	if event.is_action_released("jump_p%s" % player.player_id)\
		and player._velocity.y < -player.min_jump_velocity:
		player._velocity.y = -player.min_jump_velocity
	.handle_input(event)


func physics_update(delta):
	if (player._velocity.y >= 0):
		state_machine.transition_to("Fall")
	
	var input_direction = player.get_input_direction()
	player._input_direction = input_direction
	player._apply_gravity(delta)
	player._apply_movement(delta)


