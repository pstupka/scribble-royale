extends ParallaxBackground

export var speed = 30.0
var velocity_x = 10.0


func _process(delta: float) -> void:
	velocity_x = lerp(velocity_x, speed, delta)

	for layer in get_children():
		layer.motion_offset.x += layer.motion_scale.x * velocity_x * delta

