extends RigidBody2D

var damage: float = 20
var modifier: float = 1
var color: Color setget set_color

export var explosion_particles_scene: PackedScene
onready var pivot: = $Pivot
onready var sprite: = $Pivot/Sprite


func _ready() -> void:
	randomize()


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	var xform = state.get_transform()
	state.set_transform(Transform2D(linear_velocity.angle(), xform.get_origin()))


func _process(_delta: float) -> void:
	if position.y > 1000:
		call_deferred("queue_free")


func destroy() -> void:
	if explosion_particles_scene:
		var explosion_instance = explosion_particles_scene.instance()
		get_tree().current_scene.add_child(explosion_instance)
		explosion_instance.init(color)
		explosion_instance.global_transform = global_transform
	call_deferred("queue_free")


func set_color(new_color: Color) -> void:
	color = new_color
	sprite.self_modulate = new_color
	

func _on_Arrow_body_entered(_body: TileMap) -> void:
	call_deferred("set_mode", RigidBody2D.MODE_STATIC)
	$CollisionShape2D.call_deferred("set_disabled", true)
	var tween = get_tree().create_tween()
	tween.tween_property(pivot, "rotation_degrees", 0.0, 0.6)\
		.from(25.0)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_callback(self, "destroy").set_delay(2.0)
