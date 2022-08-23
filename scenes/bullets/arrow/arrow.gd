extends RigidBody2D


export var damage: float = 10
export var modifier: float = 1


func destroy() -> void:
	call_deferred("queue_free")


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	var xform = state.get_transform()
	state.set_transform(Transform2D(linear_velocity.angle(), xform.get_origin()))


func _on_Arrow_body_entered(_body: Node) -> void:
	call_deferred("set_mode", RigidBody2D.MODE_STATIC)
	$CollisionShape2D.call_deferred("set_disabled", true)
