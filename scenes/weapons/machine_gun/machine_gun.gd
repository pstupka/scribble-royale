extends Weapon


onready var bullet_scene: PackedScene = preload("res://scenes/bullets/bullet-basic/bullet-basic.tscn")
onready var sprite: Sprite = get_node("%Sprite")
onready var pivot: = $Pivot


func _ready() -> void:
	cooldown_timer.one_shot = false


func _process(_delta) -> void:
	sprite.scale.y = sign(cos(global_rotation))


func attack() -> void:
	if ammo > 0 and can_attack:
		spawn_bullet()
		$AnimationPlayer.play("shoot")


func drop() -> void:
	pass


func set_color(new_color: Color) -> void:
	sprite.self_modulate = new_color
	.set_color(new_color)


func spawn_bullet() -> void:
	var bullet_instance = bullet_scene.instance()
	var shoot_direction = Vector2.RIGHT.rotated(global_rotation + (randf() - 0.5) * spread_factor).normalized()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.global_transform = $SpawnPoint.global_transform
	bullet_instance.color = color
	bullet_instance.direction = shoot_direction
	bullet_instance.damage = 2


func _on_cooldown_timer_timeout() -> void:
	attack()


func _on_attack_pressed() -> void:
	attack()
	cooldown_timer.start()


func _on_attack_released() -> void:
	cooldown_timer.stop()
