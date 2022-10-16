extends RigidBody2D


func _ready() -> void:
	randomize()
	add_to_group("bodies")


func take_damage(_damage: float) -> void:
	apply_central_impulse(Vector2.UP * (randf() * 50 + 150))
	apply_torque_impulse(sign(randf() - 0.5) * (randf() * 100 + 150))


func _process(_delta) -> void:
	if global_position.y > 2000:
		queue_free()
