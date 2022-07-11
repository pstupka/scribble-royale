extends Area2D

var shot = false
var velocity = Vector2(1, 0)

func _ready() -> void:
	gravity = gravity * 10
	$CollisionShape2D.disabled = true

func _physics_process(delta: float) -> void:
	if shot: 
		velocity.y += gravity * delta
		position += velocity * delta
		rotation = velocity.angle()

func shoot(vel) -> void:
	$CollisionShape2D.disabled = false
	velocity = vel
	shot = true


func _on_Arrow_body_entered(body: Node) -> void:
	if body.is_in_group("Tile"): set_physics_process(false)
