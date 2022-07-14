extends Node2D

onready var arrow_scene = preload("res://src/Arrow.tscn")

onready var shoot_tween = $ShootTween
onready var chord : Line2D = $Chord/Line2D

var ARROW_VELOCITY = 1500

var start_position : Vector2 = Vector2(23, 5)
var end_position : Vector2 = Vector2(-10, 0)
var arrow_offset = Vector2(25, 0)
var can_shot = true

var strength = 0.0 
var arrow

func _ready() -> void:
	$Hand2.position = start_position
	arrow = arrow_scene.instance()
	$Hand2.add_child(arrow)
	arrow.position += arrow_offset
	arrow.mode = RigidBody2D.MODE_STATIC 
	randomize()
	

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		prepare()
	if Input.is_action_just_released("shoot"):
		shot()

func prepare() -> void:
	strength = 0
	shoot_tween.stop_all()
	shoot_tween.remove_all()
	shoot_tween.interpolate_property($Hand2, "position", start_position, end_position, 1.0, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	shoot_tween.interpolate_property(self, "strength", 0, 1, 1.0, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	shoot_tween.interpolate_method(self, "set_chord_point", start_position, end_position, 1.0, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	shoot_tween.start()


func shot() -> void:
	shoot_tween.stop_all()
	shoot_tween.remove_all()
	shoot_tween.interpolate_property($Hand2, "position", $Hand2.position, start_position, 0.4, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	shoot_tween.interpolate_method(self, "set_chord_point", chord.points[1], start_position, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	shoot_tween.start()
	
	if (can_shot):
		var transf : Transform2D = arrow.global_transform
		arrow.set_as_toplevel(true)
		arrow.global_transform = transf
		var direction = global_position.direction_to(get_global_mouse_position()).normalized()
		arrow.mode = RigidBody2D.MODE_RIGID 
		arrow.apply_central_impulse(direction * ARROW_VELOCITY * strength)
		$Timer.start(0.4)
		can_shot = false


func set_chord_point(new_point) -> void:
	chord.points[1] = new_point


func _on_Timer_timeout() -> void:
	arrow = arrow_scene.instance()
	$Hand2.add_child(arrow)
	arrow.position += arrow_offset
	arrow.mode = RigidBody2D.MODE_STATIC 
	can_shot = true
