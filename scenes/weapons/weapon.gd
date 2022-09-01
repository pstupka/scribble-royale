class_name Weapon
extends Node2D

export(float) var cooldown := 0.1
var cooldown_timer: Timer = Timer.new()
var can_attack: bool = true

var damage: float = 0.0
var ammo: int = 1000

var color: Color setget set_color


func _ready() -> void:
	add_child(cooldown_timer)
	cooldown_timer.wait_time = cooldown
	cooldown_timer.connect("timeout", self, "_on_cooldown_timer_timeout")


func attack() -> void:
	pass


func drop() -> void:
	pass


func cooldown() -> void:
	cooldown_timer.start()
	can_attack = false


func set_color(new_color: Color) -> void:
	color = new_color


func _on_cooldown_timer_timeout() -> void:
	can_attack = true
