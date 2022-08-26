extends Weapon


onready var arrow_scene: PackedScene = preload("res://scenes/bullets/arrow/arrow.tscn")
onready var can_shoot_raycast: RayCast2D = $RayCast2D

export var shoot_strength = 3000


func attack() -> void:
	if ammo > 0 and not can_shoot_raycast.is_colliding():
		spawn_arrow()


func drop() -> void:
	pass


func set_color(new_color: Color) -> void:
	$Sprite.self_modulate = new_color
	.set_color(new_color)


func spawn_arrow() -> void:
	var arrow_instance = arrow_scene.instance()
	var shoot_direction = Vector2.RIGHT.rotated(global_rotation).normalized()
	get_tree().current_scene.add_child(arrow_instance)
	arrow_instance.global_transform = $SpawnPoint.global_transform
	arrow_instance.color = color
	arrow_instance.apply_impulse(Vector2.ZERO, shoot_direction * shoot_strength)