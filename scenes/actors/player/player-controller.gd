class_name Player
extends KinematicBody2D

signal took_damage(damage)

export(float) var max_speed = 200.0
export(float) var gravity = 1500.0
export(float) var max_jump_velocity = 1000.0
export(float) var min_jump_velocity = 600.0
export(float) var air_acceleration = 1000.0
export(float) var air_deceleration = 2000.0
export(float) var air_steering_power = 50.0

onready var weapon_pivot: = $WeaponPivot

var _velocity := Vector2.ZERO
var _speed := 0.0
var _input_direction := Vector2.ZERO


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	weapon_pivot.look_at(get_global_mouse_position())
	pass

#
#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("jump") and is_on_floor():
#		_velocity.y = -max_jump_velocity
#	if event.is_action_released("jump") and _velocity.y < -min_jump_velocity:
#		_velocity.y = -min_jump_velocity


func _apply_gravity(delta) -> void:
	_velocity.y -= gravity * delta


func _apply_movement(_delta) -> void:
	_velocity.x = lerp(_velocity.x, max_speed * _input_direction.x, 0.5)
	_velocity = move_and_slide(_velocity, Vector2.UP)


func _on_State_transitioned(state_name) -> void:
	$Label.text = state_name
