extends Node


func file_exists(path) -> bool:
	var f = File.new()
	return f.file_exists(path)


# Reparent a node under a new parent.
# Optionally updates the transform to mantain the current
# position, scale and rotation values.
func reparent_node(node: Node2D, new_parent, update_transform = false):
	var previous_xform = node.global_transform
	node.get_parent().remove_child(node)
	new_parent.add_child(node)
	if update_transform:
		node.global_transform = previous_xform


func colorize_texture(texture: Texture, color: Color) -> Texture:
	var texture_img = texture.get_data()
	var duplicate_image = texture_img.duplicate()
	duplicate_image.fill(color)
	texture_img.blend_rect_mask(duplicate_image,
		texture_img,
		Rect2(Vector2.ZERO, texture.get_size()),
		Vector2.ZERO)
	var new_image_texture := ImageTexture.new()
	new_image_texture.create_from_image(texture_img)
	return new_image_texture
	
