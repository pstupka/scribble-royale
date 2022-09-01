class_name Hurtbox
extends Area2D


func _init() -> void:
	collision_layer = 0
	collision_mask = 2+16


func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")
	connect("body_entered", self, "_on_body_entered")


func _on_area_entered(hitbox: Hitbox) -> void:
	if not hitbox:
		return
	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)

	if hitbox.owner.has_method("destroy"):
		hitbox.owner.destroy()

func _on_body_entered(body) -> void:
	if body.has_method("destroy"):
		body.destroy()
	
	if owner.has_method("take_damage"):
		owner.take_damage(body.damage)
