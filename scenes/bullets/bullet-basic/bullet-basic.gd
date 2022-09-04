extends Area2D

var collided_canvas: Sprite
var collided_layer: SplatLayer
var global_collision_position: Vector2
var relative_collision_position: Vector2
var canvas_light_mask: int
var has_collided := false

var damage: float = 5
var modifier: float = 1
var color: Color setget set_color\

export var explosion_particles_scene: PackedScene

export(Array, Texture) var splat_textures

var direction = Vector2.ZERO
export(float) var speed := 1000.0


func _ready() -> void:
	$Hitbox.damage = damage


func _physics_process(delta) -> void:
	position += direction * speed * delta


func destroy() -> void:
	if explosion_particles_scene:
		var explosion_instance = explosion_particles_scene.instance()
		get_tree().current_scene.add_child(explosion_instance)
		explosion_instance.init(color)
		explosion_instance.global_transform = global_transform
	call_deferred("queue_free")


func set_disabled(value: bool) -> void:
	monitorable = !value
	monitoring = !value


func _on_body_entered(body: TileMap):
	collided_layer = body.get_node('SplatLayer') as SplatLayer
	collided_canvas = body.get_node('SplatLayer/Canvas') as Sprite
	global_collision_position = global_position
	relative_collision_position = global_position - collided_canvas.global_position 
	canvas_light_mask = collided_canvas.light_mask
	
	draw_spot(collided_canvas.texture,
		splat_textures[randi() % splat_textures.size()],
		relative_collision_position,
		color)
	destroy()


func draw_spot(target: Texture, spot: Texture, pos: Vector2, color: Color) -> void:
	var size = spot.get_size()
	var dst = pos - size/2
	
	var target_img := target.get_data()
	
	var spot_img = spot.get_data()
	var duplicate_image = spot_img.duplicate()
	duplicate_image.fill(color)
	spot_img.blend_rect_mask(duplicate_image, spot_img, Rect2(Vector2.ZERO, size), Vector2.ZERO)
	
	target_img.blend_rect(spot_img, Rect2(Vector2.ZERO, size), dst)
	VisualServer.texture_set_data(target.get_rid(), target_img)


func set_color(new_color: Color) -> void:
	color = new_color
	$Sprite.self_modulate = new_color


func _on_tree_entered() -> void:
	has_collided = false


func _on_VisibilityNotifier2D_screen_exited() -> void:
	call_deferred("queue_free")
