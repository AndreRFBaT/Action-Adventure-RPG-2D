extends Node


var current_tilemap_bounds : Array [ Vector2 ] 
signal TileMapBoundsChange( bounds : Array[ Vector2 ] )


func ChangeTilemapBounds ( bounds : Array[ Vector2 ] ) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundsChange.emit( bounds )
