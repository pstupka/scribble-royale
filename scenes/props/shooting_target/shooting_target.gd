extends Node2D


func take_damage(_damage: float) -> void:
	$AnimationPlayer.play("take_damage")
