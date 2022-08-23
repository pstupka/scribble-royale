class_name Hitbox
extends Area2D

var damage: float = 10.0


func _init() -> void:
	collision_layer = 16
	collision_mask = 0
