class_name Player
extends KinematicBody2D

signal attack_action_pressed
signal attack_action_released
signal player_died(id)

const MAX_FALL_SPEED = 1000

onready var _rigid_item_scene: = preload("res://scenes/props/rigid-item/rigid-item.tscn")

export(String) var player_id = "k" setget set_player_id
var color setget set_player_color

export(Color) var initial_color = Globals.COLORS.Purple
export(PackedScene) var weapon_scene: PackedScene 
export var footstep_scene: PackedScene = preload("res://scenes/effects/particle_effects/footstep.tscn")
var weapon: Weapon

export(float) var max_speed = 200.0
export(float) var gravity = 1500.0
export(float) var max_jump_velocity = 1000.0
export(float) var min_jump_velocity = 600.0

export(float) var rotation_speed = 40.0

onready var body_pivot: = $BodyPivot
onready var weapon_pivot: = $WeaponPivot
onready var health_indicator: = $HealthIndicator

var max_health: float = 100.0
var health: float = 100.0

onready var hat: = $BodyPivot/Hat

onready var input_map : Dictionary

var _velocity := Vector2.ZERO
var _speed := 0.0
var _input_direction := Vector2.ZERO
var move_threshold = 0.2

export(int) var multi_jump := 2
var multi_jump_counter

export (int) var inertia = 1000

export var immune: bool = false
export var can_take_damage: bool = true

var color_id = 0

func _ready() -> void:
	randomize()
	multi_jump_counter = multi_jump
	
	health_indicator.max_value = max_health
	health_indicator.value = health
	
	immune = false
	
	set_player_color(initial_color)
	set_player_id(player_id)
	if weapon_scene:
		equip_weapon(weapon_scene.instance())


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(input_map.attack) and weapon:
		emit_signal("attack_action_pressed")
	if event.is_action_released(input_map.attack) and weapon:
		emit_signal("attack_action_released")
	
	if event.is_action_pressed("color"):
		color_id = wrapi(color_id + 1, 0, Globals.COLORS_ARRAY.size()-1)
		set_player_color(Globals.COLORS_ARRAY[color_id] )
		if weapon:
			weapon.color = Globals.COLORS_ARRAY[color_id] 


func _physics_process(delta: float) -> void:
	_input_direction = get_input_direction()
	if _input_direction:
		var angle_to = weapon_pivot.transform.x.angle_to(_input_direction)
		weapon_pivot.rotate(sign(angle_to) * min(delta * rotation_speed, abs(angle_to)))
		var look_direction = sign(cos(weapon_pivot.global_rotation))
		body_pivot.get_node("Hat").scale.x = look_direction
		body_pivot.get_node("Mouth").scale.x = look_direction
		body_pivot.get_node("Eyes").scale.x = look_direction
	
	if global_position.y > 2000: 
		die()

func _apply_gravity(delta) -> void:
	_velocity.y -= gravity * delta
	_velocity.y = clamp(_velocity.y, -MAX_FALL_SPEED, MAX_FALL_SPEED)


func _apply_movement(_delta, weight: float = 0.5) -> void:
	_velocity.x = lerp(_velocity.x, sign(_input_direction.x) * max_speed * pow(_input_direction.x, 2), weight)
	_velocity = move_and_slide(_velocity, Vector2.UP, true, 4, PI/4, false)
	
	# after calling move_and_slide()
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * inertia)


func take_damage(damage: float) -> void:
	if not immune:
		if can_take_damage:
			var tween: = get_tree().create_tween()\
				.set_trans(Tween.TRANS_QUART)\
				.set_ease(Tween.EASE_OUT)
			health -= damage
			health = clamp(health, 0, max_health)
			tween.tween_property(health_indicator, "value", health, 0.2)
			$BodyPivot/Mouth.set_emotion(health/max_health)
			
		$CombatAnimationPlayer.play("hurt")
		
		_velocity = Vector2.ZERO
		
		Events.emit_signal("player_hurt", player_id, 0.7)
	
	if health <= 0:
		die()


func die() -> void:
	if hat:
		var rigid_drop: RigidBody2D = _rigid_item_scene.instance()
		rigid_drop.get_node("Sprite").texture = $BodyPivot/Hat.texture
		get_tree().current_scene.call_deferred("add_child", rigid_drop)
		rigid_drop.global_transform = $BodyPivot/Hat.global_transform

	emit_signal("player_died", player_id)
	call_deferred("queue_free")


func get_input_direction() -> Vector2:
	return Input.get_vector(
		input_map.move_left,
		input_map.move_right,
		input_map.move_up,
		input_map.move_down)


func spawn_footstep() -> void:
	var footstep_instance = footstep_scene.instance()
	add_child(footstep_instance)
	footstep_instance.init(color)
	footstep_instance.process_material.direction = Vector3(
		-sign(_velocity.x),
		-sign(_velocity.y),
		0)
	footstep_instance.process_material.initial_velocity = min(_velocity.length(), 40)
	footstep_instance.position = $BodyPivot/FootstepSpawn.position


func multi_jump_reset() -> void:
	multi_jump_counter = multi_jump


func equip_weapon(new_weapon: Weapon) -> void:
	if weapon:
		weapon.call_deferred("queue_free")
	weapon = new_weapon
	weapon_pivot.add_child(weapon)
	weapon.color = color
	weapon.equip(self)
	connect("attack_action_pressed", weapon, "_on_attack_pressed")
	connect("attack_action_released", weapon, "_on_attack_released")


func pickup(resource: Resource) -> void:
	if resource.type == "Weapon":
		call_deferred("equip_weapon", resource.item_scene.instance())


func set_player_color(new_color: Color) -> void:
	color = new_color
	$BodyPivot/Fill.self_modulate = new_color
	health_indicator.tint_progress = new_color


func set_player_id(new_id: String) -> void:
	player_id = new_id
	input_map = {
		"move_left": "move_left_%s" % player_id,
		"move_right": "move_right_%s" % player_id,
		"move_up": "move_up_%s" % player_id,
		"move_down": "move_down_%s" % player_id,
		"jump": "jump_%s" % player_id,
		"attack": "attack_%s" % player_id,
		"secondary_attack": "secondary_attack_%s" % player_id,
		"lock_move": "lock_move_%s" % player_id,
	}
