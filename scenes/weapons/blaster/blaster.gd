extends Weapon


onready var bullet_scene: PackedScene = preload("res://scenes/bullets/bullet-basic/bullet-basic.tscn")
export var shoot_strength = 1500


func attack() -> void:
	if ammo > 0:
		spawn_bullet()


func drop() -> void:
	pass


func set_color(new_color: Color) -> void:
	$Sprite.self_modulate = new_color
	.set_color(new_color)


func spawn_bullet() -> void:
	var bullet_instance = bullet_scene.instance()
	var shoot_direction = Vector2.RIGHT.rotated(global_rotation).normalized()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.global_transform = $SpawnPoint.global_transform
	bullet_instance.color = color
	bullet_instance.direction = shoot_direction

