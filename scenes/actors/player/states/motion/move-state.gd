extends PlayerState

func enter(_msg := {}):
	player.get_node("AnimationPlayer").play("move")


func handle_input(event):
	if event.is_action_pressed("jump") and player.is_on_floor():
		state_machine.transition_to("Jump")


func physics_update(delta):	
	var input_direction = get_input_direction()
	player._input_direction = input_direction
	player._apply_gravity(delta)
	player._apply_movement(delta)

	if is_equal_approx(input_direction.x, 0.0):
		state_machine.transition_to("Idle")
	if not player.is_on_floor():
		state_machine.transition_to("Fall", {"coyote_jump": true})

func exit() -> void:
	player.get_node("AnimationPlayer").stop(true)
