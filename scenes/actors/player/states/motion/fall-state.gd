extends PlayerState

var coyote_timer: Timer = Timer.new()
var coyote_jump = false

func _ready() -> void:
	add_child(coyote_timer)
	coyote_timer.connect("timeout", self, "_on_coyote_timer_timeout")
	coyote_timer.autostart = false
	coyote_timer.wait_time = 0.1


func enter(msg := {}):
	player.get_node("AnimationPlayer").play("idle")
	if msg.has("coyote_jump"):
		coyote_timer.start()
		coyote_jump = true
#	if event.is_action_released("jump") and _velocity.y < -min_jump_velocity:
#		_velocity.y = -min_jump_velocity


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and coyote_jump:
		state_machine.transition_to("Jump")


func physics_update(delta):
	if player.is_on_floor():
		if is_equal_approx(player._velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Move")
	
	var input_direction = get_input_direction()
	player._input_direction = input_direction
	player._apply_gravity(delta)
	player._apply_movement(delta)


func _on_coyote_timer_timeout() -> void:
	coyote_jump = false

