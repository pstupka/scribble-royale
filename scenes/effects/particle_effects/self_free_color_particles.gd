extends Particles2D

export(float) var destroy_delay = 0.5

var destroy_timer: Timer = Timer.new()

func _ready() -> void:
	add_child(destroy_timer)
	destroy_timer.start(destroy_delay)
	destroy_timer.connect("timeout", self, "_on_destroy_timer_timeout")


func init(color: Color) -> void:
	self_modulate = color


func _on_destroy_timer_timeout() -> void:
	call_deferred("queue_free")
