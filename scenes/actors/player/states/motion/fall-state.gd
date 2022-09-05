extends PlayerState

var coyote_timer: Timer = Timer.new()
var coyote_jump = false
export(float) var acceleration_weight: = 0.05

func _ready() -> void:
	add_child(coyote_timer)
	coyote_timer.connect("timeout", self, "_on_coyote_timer_timeout")
	coyote_timer.autostart = false
	coyote_timer.wait_time = 0.1


func enter(msg := {}):
	player.get_node("AnimationPlayer").play("fall")
	if msg.has("coyote_jump"):
		coyote_timer.start()
		coyote_jump = true
	if not msg.has("double_jump"):
		player.multi_jump_counter = 0



func handle_input(event: InputEvent) -> void:
	if (event.is_action_pressed("jump_p%s" % player.player_id) and (coyote_jump or player.multi_jump_counter > 0)):
		state_machine.transition_to("Jump")



func physics_update(delta):
	if player.is_on_floor():
		if is_equal_approx(player._velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Move")
	
	player._apply_gravity(delta)
	player._apply_movement(delta, acceleration_weight)


func _on_coyote_timer_timeout() -> void:
	coyote_jump = false

