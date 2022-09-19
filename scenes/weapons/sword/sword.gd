extends Weapon

onready var pivot: = $Pivot
onready var animation_player = $AnimationPlayer
onready var hitbox = get_node("%Hitbox")


func _process(_delta) -> void:
	pivot.scale.y = sign(cos(global_rotation))


func equip(new_owner) -> void:
	hitbox.attacker = new_owner


func attack() -> void:
	animation_player.play("attack")


func drop() -> void:
	pass


func set_color(new_color: Color) -> void:
	pivot.modulate = new_color
	.set_color(new_color)


func _on_attack_pressed() -> void:
	if can_attack:
		attack()


func _on_attack_released() -> void:
	if can_attack:
		print("le attack released")	
