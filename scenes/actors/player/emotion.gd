extends Sprite

enum Emotion {HAPPY, SAD, NEUTRAL, SURPRISED}
var current_emotion: int = Emotion.HAPPY

func _ready() -> void:
	set_emotion(1)

func set_emotion(health_percent: float) -> void:
	if health_percent < 0.7:
		current_emotion = Emotion.NEUTRAL
	if health_percent < 0.3:
		current_emotion = Emotion.SAD
	region_rect = Rect2(48 * current_emotion , 0, 48, 64)


