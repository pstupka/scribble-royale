extends Area2D
class_name PickableItem

export(Resource) var item_template
var _can_pick = true

func _ready() -> void:
	if item_template:
		$Sprite.texture = item_template.item_sprite
	
	var tween = create_tween().set_loops()
	tween.tween_property($Sprite, "position", Vector2(0, -10), 1)
	tween.tween_property($Sprite, "position", Vector2(0, 0), 1)


func _on_PickableItem_body_entered(body: Player):
	if body and _can_pick:
		_can_pick = false
		body.pickup(item_template)
		call_deferred("queue_free")
