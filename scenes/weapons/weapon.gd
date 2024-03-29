class_name Weapon
extends Node2D

export(float) var cooldown_time := 0.1 setget set_cooldown_time
export(float) var spread_factor := 0.1
var cooldown_timer: Timer = Timer.new()
var can_attack: bool = true

var damage: float = 0.0
var ammo: int = 1000

var color: Color setget set_color

var is_discoverable: bool = true


func _ready() -> void:
	add_child(cooldown_timer)
	cooldown_timer.wait_time = cooldown_time
	cooldown_timer.one_shot = true
	cooldown_timer.connect("timeout", self, "_on_cooldown_timer_timeout")
	Events.connect("game_paused", self, "_on_game_paused")
	Events.connect("game_resumed", self, "_on_game_resumed")


func equip(_owner) -> void:
	pass


func attack() -> void:
	if ammo <= 0:
		can_attack = false
		cooldown_timer.stop()
		return
	ammo -= 1

func drop() -> void:
	pass


func cooldown() -> void:
	cooldown_timer.start()
	can_attack = false


func set_color(new_color: Color) -> void:
	color = new_color


func set_cooldown_time(time: float) -> void:
	cooldown_time = time
	cooldown_timer.wait_time = time


func _on_cooldown_timer_timeout() -> void:
	can_attack = true


func _on_attack_pressed() -> void:
	pass


func _on_attack_released() -> void:
	pass


func _on_game_paused() -> void:
	pass


func _on_game_resumed() -> void:
	pass
