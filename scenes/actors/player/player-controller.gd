class_name Player
extends KinematicBody2D

signal attack_action_pressed
signal attack_action_released

const MAX_FALL_SPEED = 1000

export(int) var player_id = 0
var color setget set_player_color

export(Color) var initial_color = Globals.COLORS.Purple
export(PackedScene) var weapon_scene: PackedScene = preload("res://scenes/weapons/blaster/blaster.tscn")
export var footstep_scene: PackedScene = preload("res://scenes/effects/particle_effects/footstep.tscn")
var weapon: Weapon

export(float) var max_speed = 200.0
export(float) var gravity = 1500.0
export(float) var max_jump_velocity = 1000.0
export(float) var min_jump_velocity = 600.0

export(float) var rotation_speed = 10.0

onready var body_pivot: = $BodyPivot
onready var weapon_pivot: = $WeaponPivot
onready var health_indicator: = $HealthIndicator

var max_health: float = 100.0
var health: float = 100.0

enum Emotion {HAPPY, SAD, NEUTRAL, SURPRISED}
var current_emotion: int = Emotion.HAPPY


var _velocity := Vector2.ZERO
var _speed := 0.0
var _input_direction := Vector2.ZERO
var move_threshold = 0.2

export(int) var multi_jump := 2
var multi_jump_counter


func _ready() -> void:
	randomize()

	multi_jump_counter = multi_jump
	
	health_indicator.max_value = max_health
	health_indicator.value = health
	
	set_player_color(initial_color)
	set_player_color(initial_color)
	
	equip_weapon(weapon_scene.instance())


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack_p%s" % player_id) and weapon:
		emit_signal("attack_action_pressed")
	if event.is_action_released("attack_p%s" % player_id) and weapon:
		emit_signal("attack_action_released")


func _physics_process(delta: float) -> void:
	_input_direction = get_input_direction()
	if _input_direction:
		var angle_to = weapon_pivot.transform.x.angle_to(_input_direction)
		weapon_pivot.rotate(sign(angle_to) * min(delta * rotation_speed, abs(angle_to)))
		var look_direction = sign(sign(cos(weapon_pivot.rotation)))
		body_pivot.get_node("Hat").scale.x = look_direction
		body_pivot.get_node("Mouth").scale.x = look_direction
		body_pivot.get_node("Eyes").scale.x = look_direction


func _apply_gravity(delta) -> void:
	_velocity.y -= gravity * delta
	_velocity.y = clamp(_velocity.y, -MAX_FALL_SPEED, MAX_FALL_SPEED)


func _apply_movement(_delta, weight: float = 0.5) -> void:
	_velocity.x = lerp(_velocity.x, sign(_input_direction.x) * max_speed * pow(_input_direction.x, 2), weight)
	_velocity = move_and_slide(_velocity, Vector2.UP, true)


func take_damage(damage: float) -> void:
	var tween: = get_tree().create_tween()\
		.set_trans(Tween.TRANS_QUART)\
		.set_ease(Tween.EASE_OUT)
	health -= damage
	health = clamp(health, 0, max_health)
	tween.tween_property(health_indicator, "value", health, 0.2)
	set_emotion()
	if health <= 0:
		die()


func die() -> void:
	call_deferred("queue_free")


func get_input_direction() -> Vector2:
	return Input.get_vector(
		"move_left_p%s" % player_id,
		"move_right_p%s" % player_id,
		"move_up_p%s" % player_id,
		"move_down_p%s" % player_id)


func spawn_footstep() -> void:
	var footstep_instance = footstep_scene.instance()
	add_child(footstep_instance)
	footstep_instance.init(color)
	footstep_instance.process_material.direction.x = -sign(_input_direction.x)
	footstep_instance.set_as_toplevel(true)
	footstep_instance.global_position = $BodyPivot/FootstepSpawn.global_position


func multi_jump_reset() -> void:
	multi_jump_counter = multi_jump


func equip_weapon(new_weapon: Weapon) -> void:
	if weapon:
		weapon.call_deferred("queue_free")
	weapon = new_weapon
	weapon_pivot.add_child(weapon)
	weapon.color = color
	connect("attack_action_pressed", weapon, "_on_attack_pressed")
	connect("attack_action_released", weapon, "_on_attack_released")


func set_emotion() -> void:
	if health < 0.7 * max_health:
		current_emotion = Emotion.NEUTRAL
	if health < 0.3 * max_health:
		current_emotion = Emotion.SAD
	$BodyPivot/Mouth.region_rect = Rect2(48 * current_emotion , 0, 48, 64)


func set_player_color(new_color: Color) -> void:
	color = new_color
	$BodyPivot/Fill.self_modulate = new_color
	health_indicator.tint_progress = new_color
