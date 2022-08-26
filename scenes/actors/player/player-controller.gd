class_name Player
extends KinematicBody2D

signal took_damage(damage)

export(int) var player_id = 0
var color setget set_player_color

export(Color) var initial_color = Globals.COLORS.Purple

export(float) var max_speed = 200.0
export(float) var gravity = 1500.0
export(float) var max_jump_velocity = 1000.0
export(float) var min_jump_velocity = 600.0
export(float) var air_acceleration = 1000.0
export(float) var air_deceleration = 2000.0
export(float) var air_steering_power = 50.0

export(float) var rotation_speed = 10.0

onready var weapon_pivot: = $WeaponPivot
onready var weapon: = $WeaponPivot/Bow
onready var health_indicator: = $HealthIndicator

var max_health: float = 100.0
var health: float = 100.0

enum Emotion {HAPPY, SAD, NEUTRAL, SURPRISED}
var current_emotion: int = Emotion.HAPPY

var _velocity := Vector2.ZERO
var _speed := 0.0
var _input_direction := Vector2.ZERO


func _ready() -> void:
	randomize()
	$BodyPivot/Outline.frame = randi() % 4
	set_player_color(initial_color)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack_p%s" % player_id):
		weapon.attack()


func _process(delta: float) -> void:
	var look_direction = get_input_direction()
	if look_direction:
		var angle_to = weapon_pivot.transform.x.angle_to(look_direction)
		weapon_pivot.rotate(sign(angle_to) * min(delta * rotation_speed, abs(angle_to)))


func _apply_gravity(delta) -> void:
	_velocity.y -= gravity * delta


func _apply_movement(_delta) -> void:
	_velocity.x = lerp(_velocity.x, max_speed * _input_direction.x, 0.5)
	_velocity = move_and_slide(_velocity, Vector2.UP)


func take_damage(damage: float) -> void:
	var tween: = get_tree().create_tween()\
		.set_trans(Tween.TRANS_QUART)\
		.set_ease(Tween.EASE_OUT)
	health -= damage
	
	if health > 0:
		tween.tween_property(health_indicator, "value", health, 0.2)
		set_emotion()
	else:
		tween.tween_property(health_indicator, "value", 0.0, 0.2)
		die()


func die() -> void:
	call_deferred("queue_free")


func get_input_direction() -> Vector2:
	return Input.get_vector(
		"move_left_p%s" % player_id,
		"move_right_p%s" % player_id,
		"move_up_p%s" % player_id,
		"move_down_p%s" % player_id)


func set_emotion() -> void:
	if health < 0.7 * max_health:
		current_emotion = Emotion.NEUTRAL
	if health < 0.3 * max_health:
		current_emotion = Emotion.SAD
	$BodyPivot/Mouth.region_rect = Rect2(48 * current_emotion , 0, 48, 64)


func set_player_color(new_color: Color) -> void:
	color = new_color
	$BodyPivot/Fill.self_modulate = new_color
	$HealthIndicator.tint_progress = new_color
	weapon.color = new_color


func _on_State_transitioned(state_name) -> void:
	$Label.text = state_name


func _on_BlinkTimer_timeout() -> void:
	$BodyPivot/BlinkTimer.wait_time = randi() % 6 + 1
	$BodyPivot/Eyes.frame = 0
	$BodyPivot/Eyes.play("blink")
