extends PlayerState

export(float) var acceleration_weight: = 0.05

func enter(_msg := {}):
	player.get_node("AnimationPlayer").play("jump")
	player._velocity.y = -player.max_jump_velocity
	player.multi_jump_counter -= 1


func handle_input(event: InputEvent) -> void:
	if event.is_action_released("jump_p%s" % player.player_id)\
		and player._velocity.y < -player.min_jump_velocity:
		player._velocity.y = -player.min_jump_velocity
		
	if event.is_action_pressed("jump_p%s" % player.player_id) and \
		player.multi_jump_counter > 0:
		state_machine.transition_to("Jump")
	.handle_input(event)


func physics_update(delta):
	if (player._velocity.y >= 0):
		state_machine.transition_to("Fall", { "double_jump": true })
	
	player._apply_gravity(delta)
	player._apply_movement(delta, acceleration_weight)


