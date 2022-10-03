extends Area2D
class_name PickableItem

const sprite_w = 96

onready var sprite: = $Pivot/Sprite
onready var pivot:= $Pivot

export(Resource) var item_template
export var permanent: = true
var _can_pick: = true

func _ready() -> void:
	randomize()
	if item_template:
		sprite.texture = item_template.item_sprite
	
	var tween = create_tween().set_loops()
	tween.tween_property(pivot, "position:y", -10.0, 2)
	tween.tween_property(pivot, "position:y", 0.0, 2)


func _on_PickableItem_body_entered(body: Player):
	if body and _can_pick:
		body.pickup(item_template)
		if not permanent:
			_can_pick = false
			call_deferred("queue_free")
