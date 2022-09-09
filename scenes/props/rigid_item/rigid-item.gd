extends RigidBody2D


func _ready() -> void:
	randomize()


func take_damage(_damage: float) -> void:
	var random = randf()
	var vec = Vector2.UP * (randf() * 500 + 1500)
	apply_central_impulse(vec)
	apply_torque_impulse(sign(random - 0.5) * (random * 500 + 1500))
