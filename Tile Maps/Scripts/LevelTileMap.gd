class_name LevelTileMap extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.ChangeTilemapBounds( GetTilemapBounds() )
	pass # Replace with function body.s

func GetTilemapBounds() -> Array[ Vector2 ]:
	var bounds : Array [ Vector2 ] = []
	#bounds.append(
		#Vector2( get_used_rect().position * rendering_quadrant_size )
	#)
	#bounds.append(
		#Vector2( get_used_rect().end * rendering_quadrant_size)
	#)
	#return bounds
	# Get the tileset and tile size
	var tile_size : Vector2 = Vector2(tile_set.tile_size)
	var used_rect : Rect2 = Rect2(get_used_rect())

	# Add the tilemap position to the bounds (offset)
	bounds.append(
		global_position + (used_rect.position * tile_size)
	)
	bounds.append(
		global_position + (used_rect.end * tile_size)
	)
	return bounds
