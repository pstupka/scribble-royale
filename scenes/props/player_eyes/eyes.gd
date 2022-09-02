extends AnimatedSprite

export(float) var blink_time := 6.0
export(bool) var blink_enabled := true

func _ready():
	if not blink_enabled:
		return
	$BlinkTimer.start()
	$BlinkTimer.connect("timeout", self, "_on_BlinkTimer_timeout")


func _on_BlinkTimer_timeout() -> void:
	$BlinkTimer.wait_time = randf() * blink_time
	frame = 0
	play("blink")
