extends Weapon

onready var pivot: = $Pivot
onready var spawn_point: = $SpawnPoint
onready var arrow_scene: PackedScene = preload("res://scenes/bullets/arrow/arrow.tscn")
onready var can_shoot_raycast: RayCast2D = $RayCast2D
onready var arrow_sprite = $Pivot/ItemArrow

export var shoot_strength: float = 3000.0

export var hand_start_position: = Vector2(26, -5)
export var hand_end_position: = Vector2(-10, 0)

export var arrow_start_position = Vector2(49, -5)
export var arrow_end_position = Vector2(13, 0)

var _arrow_prepared: bool = true

var tween: SceneTreeTween

func _process(_delta) -> void:
	pivot.scale.y = sign(cos(global_rotation))
	spawn_point.position.y = sign(cos(global_rotation)) * abs(spawn_point.position.y)


func attack() -> void:
	if ammo > 0 and not can_shoot_raycast.is_colliding() and can_attack:
		spawn_arrow()
		cooldown()


func drop() -> void:
	pass


func set_color(new_color: Color) -> void:
	pivot.modulate = new_color
	.set_color(new_color)


func spawn_arrow() -> void:
	arrow_sprite.hide()
	var arrow_instance = arrow_scene.instance()
	var shoot_direction = Vector2.RIGHT.rotated(global_rotation + (randf() - 0.5) * spread_factor).normalized()
	get_tree().current_scene.add_child(arrow_instance)
	arrow_instance.global_transform = $SpawnPoint.global_transform
	arrow_instance.color = color
	arrow_instance.apply_impulse(Vector2.ZERO, shoot_direction * shoot_strength)


func move_string(pos: Vector2) -> void:
	$Pivot/String.points[1] = pos


func _on_cooldown_timer_timeout() -> void:
	arrow_sprite.show()
	arrow_sprite.position = arrow_start_position
	._on_cooldown_timer_timeout()


func _on_attack_pressed() -> void:
	_arrow_prepared = false
	if can_attack:
		_arrow_prepared = true
		tween = create_tween()
		tween.tween_property($Pivot/Hand, "position", hand_end_position, 1)\
			.set_trans(Tween.TRANS_QUART)\
			.set_ease(Tween.EASE_OUT)
		tween.parallel().tween_method(self, "move_string", hand_start_position, hand_end_position, 1)\
			.set_trans(Tween.TRANS_QUART)\
			.set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property($Pivot/ItemArrow, "position", arrow_end_position, 1)\
			.set_trans(Tween.TRANS_QUART)\
			.set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(self, "shoot_strength", 3000.0, 1).from(1000.0)
	

func _on_attack_released() -> void:
	if _arrow_prepared:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.tween_property($Pivot/Hand, "position", hand_start_position, 0.3)\
			.set_trans(Tween.TRANS_EXPO)\
			.set_ease(Tween.EASE_OUT)
		tween.parallel().tween_method(self, "move_string", $Pivot/String.points[1], hand_start_position, 0.4)\
			.set_trans(Tween.TRANS_ELASTIC)\
			.set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property($Pivot/ItemArrow, "position", arrow_start_position, 0.4)\
			.set_trans(Tween.TRANS_EXPO)\
			.set_ease(Tween.EASE_OUT)
		attack()
