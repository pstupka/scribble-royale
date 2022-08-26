extends Particles2D


func init(color: Color) -> void:
	self_modulate = color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emitting = true
	yield(get_tree().create_timer(0.5), "timeout")
	call_deferred("queue_free")

