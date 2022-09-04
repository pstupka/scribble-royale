extends ParallaxBackground

export var speed = 10.0
var velocity_x = 10.0


func _process(delta: float) -> void:
	velocity_x = lerp(velocity_x, speed, delta)
	for layer in get_children():
		layer.motion_offset.x += velocity_x * delta * layer.motion_scale.x
