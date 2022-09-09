extends PlayerState

var footstep_timer: Timer = Timer.new()
export(float) var acceleration_weight: = 0.1

func _ready() -> void:
	add_child(footstep_timer)
	footstep_timer.connect("timeout", self, "_on_footstep_timer_timeout")
	footstep_timer.autostart = false
	footstep_timer.wait_time = 0.2
	

func enter(_msg := {}):
	player.get_node("AnimationPlayer").play("move")
	footstep_timer.start()
	if state_machine.previous_state.name == "Fall":
		player.spawn_footstep()
	player.multi_jump_reset()


func handle_input(event):
	if event.is_action_pressed(player.input_map.jump) and player.is_on_floor():
		state_machine.transition_to("Jump")
		player.spawn_footstep()


func physics_update(delta):
	player._apply_gravity(delta)
	player._apply_movement(delta, acceleration_weight)

	if is_equal_approx(player._velocity.x, 0.0) or Input.is_action_pressed(player.input_map.lock_move):
		state_machine.transition_to("Idle")
	if not player.is_on_floor():
		state_machine.transition_to("Fall", {"coyote_jump": true})

func exit() -> void:
	player.get_node("AnimationPlayer").stop(true)
	footstep_timer.stop()


func _on_footstep_timer_timeout() -> void:
	player.spawn_footstep()
