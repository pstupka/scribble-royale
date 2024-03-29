extends ParallaxBackground

export var layers_number = 5
export var max_clouds_per_layer = 30
export var speed = 30.0

var background_color = Globals.color_palette[Globals.COLOR.DEFAULT]
var velocity_x = 10.0

func _ready() -> void:
	randomize()
	
	$Background/ColorRect.color = background_color
	
	for parallax_id in layers_number:
		var parallax_layer = ParallaxLayer.new()
		parallax_layer.motion_mirroring = Vector2(Game.size)
		add_child(parallax_layer)
	
		parallax_layer.modulate = Color(1.0, 1.0, 1.0, -0.1 + 1.0 / (layers_number - parallax_id))
		parallax_layer.motion_scale = Vector2.ONE / (layers_number - parallax_id)
		for i in max_clouds_per_layer / (parallax_id + 2):
			var cloud: = Sprite.new()
			cloud.texture = load("res://assets/sprites/background/background_cloud_%s.png" % (randi() % 1))
			parallax_layer.add_child(cloud)
			cloud.scale = Vector2.ONE / (layers_number - parallax_id)
			cloud.global_position = Vector2(randf() * Game.size.x, randf() * Game.size.y)
			cloud.self_modulate = Globals.color_palette[randi() % (Globals.color_palette.size() - 2) + 2]


func _process(delta: float) -> void:
	velocity_x = lerp(velocity_x, speed, delta)
	
	for layer in get_children():
		layer.motion_offset.x += layer.motion_scale.x * velocity_x * delta

