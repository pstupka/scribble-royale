extends Weapon


onready var arrow_scene: PackedScene = preload("res://scenes/bullets/arrow/arrow.tscn")
export var shoot_strength = 3000


func attack() -> void:
	if ammo > 0:
		spawn_arrow()


func drop() -> void:
	pass


func spawn_arrow() -> void:
	var arrow_instance = arrow_scene.instance()
	var shoot_direction = Vector2.RIGHT.rotated(global_rotation).normalized()
	get_tree().current_scene.add_child(arrow_instance)
	arrow_instance.global_transform = global_transform
	arrow_instance.apply_impulse(Vector2.ZERO, shoot_direction * shoot_strength)
	
