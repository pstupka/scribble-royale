# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _process, _unhandled_input) to the active state.
class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

export var initial_state := NodePath()

var state: State = null
var previous_state: State = null


func _ready() -> void:
	yield(owner, "ready")
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
		
	if initial_state:
		state = get_node(initial_state)
	else:
		state = get_children()[0]
	
	state.enter()


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return
	previous_state = state
	previous_state.exit()
	
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
