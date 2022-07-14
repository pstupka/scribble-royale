extends RigidBody2D

var contact_point

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
#	$ArrowSprite.rotation = linear_velocity.angle()
#	$CollisionShape2D.rotation = linear_velocity.angle()

func _on_Arrow_body_entered(body: Node) -> void:
	set_deferred("mode", RigidBody2D.MODE_STATIC)
	set_deferred("contact_monitor", false)
	if (body.is_in_group("Player")):
		call_deferred("queue_free")
#	Utils.call_deferred("reparent", self, body)
#	set_as_toplevel(false)
	
