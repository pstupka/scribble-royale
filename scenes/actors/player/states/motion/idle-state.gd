extends PlayerState

export(float) var acceleration_weight: = 0.1

func enter(_msg := {}):
	player.get_node("AnimationPlayer").play("idle")
	if state_machine.previous_state.name == "Fall":
		player.spawn_footstep()
	player.multi_jump_reset()


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump_p%s" % player.player_id) and player.is_on_floor():
		state_machine.transition_to("Jump")
		player.spawn_footstep()


# Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass


# Corresponds to the `_physics_process()` callback.
func physics_update(delta: float) -> void:
	player._apply_movement(delta, acceleration_weight)
	
	if not player.is_on_floor():
		state_machine.transition_to("Fall")
		return

	if player.get_input_direction().x:
		state_machine.transition_to("Move")

