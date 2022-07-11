extends KinematicBody2D

export var SPEED = 300
export var MAX_SPEED = 500
export var JUMP_SPEED = 400
export var MASS = 10
export var GRAVITY = 1.5

export var ACCELERATION = 60
export var DECELERATION = 1

onready var body_sprite = $BodyPivot/BodySprite

var _velocity = Vector2.ZERO
var _direction = Vector2.ZERO

var is_jumping = false

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if (global_position.direction_to(get_global_mouse_position()).x < 0.0):
		body_sprite.flip_h = true
	else:
		body_sprite.flip_h = false
	
	process_input(delta)
	move()
	
	if _velocity.y > 10:
		is_jumping = true 
		
	if is_jumping and is_on_floor():
		is_jumping = false
		$AnimationPlayer.play("land")
		

func move() -> void:
	if _direction.x == 0:
		_velocity.x = _velocity.x / DECELERATION
	else:
		_velocity.x += _direction.x * ACCELERATION
	_velocity.y += GRAVITY * MASS
	_velocity.x = clamp(_velocity.x, -SPEED, SPEED)
	_velocity.y = clamp(_velocity.y, -MAX_SPEED, MAX_SPEED)
	_velocity = move_and_slide(_velocity, Vector2.UP)



func process_input(delta: float) -> void:
	_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$AnimationPlayer.play("jump")
		is_jumping = true
		_velocity.y -= JUMP_SPEED

