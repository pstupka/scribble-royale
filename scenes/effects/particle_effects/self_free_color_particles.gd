extends Particles2D

export(float) var destroy_delay = 0.5


func _ready() -> void:
	yield(get_tree().create_timer(destroy_delay), "timeout")
	call_deferred("queue_free")


func init(color: Color) -> void:
	self_modulate = color
	emitting = true
