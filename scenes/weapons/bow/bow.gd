extends Weapon


onready var arrow_scene: PackedScene = preload("res://scenes/bullets/arrow/arrow.tscn")
export var shoot_strength = 2000

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and can_attack:
		attack()


func attack() -> void:
	if ammo > 0:
		spawn_arrow()


func drop() -> void:
	pass


func spawn_arrow() -> void:
	var arrow_instance = arrow_scene.instance()
	get_tree().current_scene.add_child(arrow_instance)
	arrow_instance.global_transform = global_transform
	arrow_instance.apply_impulse(Vector2.ZERO,Vector2(3,-1).normalized()*shoot_strength)
	
