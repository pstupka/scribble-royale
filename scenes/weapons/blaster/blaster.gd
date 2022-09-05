extends Weapon


onready var bullet_scene: PackedScene = preload("res://scenes/bullets/bullet-basic/bullet-basic.tscn")
export var shoot_strength = 1500


func _process(_delta) -> void:
	$Sprite.scale.y = sign(sign(cos(global_rotation)))


func attack() -> void:
	if ammo > 0 and can_attack:
		spawn_bullet()
		$AnimationPlayer.play("shoot")
		cooldown()


func drop() -> void:
	pass


func set_color(new_color: Color) -> void:
	$Sprite.self_modulate = new_color
	.set_color(new_color)


func spawn_bullet() -> void:
	var bullet_instance = bullet_scene.instance()
	var shoot_direction = Vector2.RIGHT.rotated(global_rotation + (randf() - 0.5) * spread_factor).normalized()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.global_transform = $SpawnPoint.global_transform
	bullet_instance.color = color
	bullet_instance.direction = shoot_direction


func _on_attack_pressed() -> void:
	attack()


func _on_attack_released() -> void:
	pass
