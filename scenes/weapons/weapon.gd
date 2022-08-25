class_name Weapon
extends Node2D


var can_attack: bool = true

var damage: float = 0.0
var ammo: int = 1000

var color: Color setget set_color


func attack() -> void:
	pass


func drop() -> void:
	pass


func set_color(new_color: Color) -> void:
	color = new_color
