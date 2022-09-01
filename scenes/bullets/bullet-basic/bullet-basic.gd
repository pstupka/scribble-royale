class_name ParticleCollider extends Area2D

signal particle_collided

var collided_canvas: Sprite
var collided_layer: SplatLayer
var global_collision_position: Vector2
var relative_collision_position: Vector2
var canvas_light_mask: int
var has_collided := false


func set_disabled(value: bool) -> void:
	monitorable = !value
	monitoring = !value


func _on_body_entered(body: TileMap):
	collided_layer = body.get_node('SplatLayer') as SplatLayer
	collided_canvas = body.get_node('SplatLayer/Canvas') as Sprite
	global_collision_position = global_position
	relative_collision_position = global_position - collided_canvas.global_position 
	canvas_light_mask = collided_canvas.light_mask
	emit_signal('particle_collided')


func draw_spot_at_collision(spot: Texture, color: Color = Color.white) -> void:
	draw_spot(collided_canvas.texture, spot, relative_collision_position, color)


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


func _on_tree_entered():
	has_collided = false
