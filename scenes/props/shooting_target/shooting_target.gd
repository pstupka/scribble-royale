extends Node2D

func _ready() -> void:
	modulate = Globals.color_palette[Globals.COLOR.WHITE]


func take_damage(_damage: float) -> void:
	$AnimationPlayer.play("take_damage")
