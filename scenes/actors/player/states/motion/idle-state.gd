extends PlayerState

export(float) var acceleration_weight: = 0.1
var falling_frames_counter = 0

func enter(_msg := {}):
	player.get_node("AnimationPlayer").play("idle")
	if state_machine.previous_state.name == "Fall":
		player.spawn_footstep()
	player.multi_jump_reset()

	player._velocity = Vector2.ZERO


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed(player.input_map.jump) and player.is_on_floor():
		state_machine.transition_to("Jump")
		player.spawn_footstep()


# Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass


# Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
#	Below line caused a problem with moving beside the wall.
#   Player in that case could not jump as is_on_floor was reported as false.

#	This move and slide in idle state was aded due to levitation bug
	player.move_and_slide(Vector2.DOWN, Vector2.UP, true, 4, PI/4, false)
	

	if not player.is_on_floor():
		state_machine.transition_to("Fall")
		return
	
	if Input.is_action_pressed(player.input_map.lock_move):
		return
	
	if player.get_input_direction().x:
		state_machine.transition_to("Move")

