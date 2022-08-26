extends RigidBody2D


var damage: float = 10
var modifier: float = 1
var color: Color setget set_color

export var explosion_particles_scene: PackedScene


func destroy() -> void:
	if explosion_particles_scene:
		var explosion_instance = explosion_particles_scene.instance()
		get_tree().current_scene.add_child(explosion_instance)
		explosion_instance.init(color)
		explosion_instance.global_transform = global_transform
	call_deferred("queue_free")


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	var xform = state.get_transform()
	state.set_transform(Transform2D(linear_velocity.angle(), xform.get_origin()))


func set_color(new_color: Color) -> void:
	color = new_color
	$Sprite.self_modulate = new_color


func _on_Arrow_body_entered(_body: Node) -> void:
	call_deferred("set_mode", RigidBody2D.MODE_STATIC)
	$CollisionShape2D.call_deferred("set_disabled", true)
	$DestroyDelay.start()
	$AnimationPlayer.play("destroy")


func _on_DestroyDelay_timeout() -> void:
	call_deferred("queue_free")
