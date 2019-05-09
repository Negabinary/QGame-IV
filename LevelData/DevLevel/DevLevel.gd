const WORLD_CHARACTERS = preload("res://Enums/WorldCharacters.gd")

var world_path = "res://LevelData/DevLevel/DevLevelWorld.tscn"

var actors = [
    {"type": WORLD_CHARACTERS.KING, "qubit":0},
	{"type": WORLD_CHARACTERS.KING, "qubit":1},
	{"type": WORLD_CHARACTERS.KING, "qubit":2}
]

var initial_state_vector = PoolVector2Array([
	Vector2(0,0), Vector2(0.5,0), Vector2(0.5,0), Vector2(0,0),
	Vector2(0,0), Vector2(0,0), Vector2(0.5,0), Vector2(0.5,0),
])

var initial_mosaic_tree = [[0, 1], [2, 3]]

var intitial_mosaic_map = [1, 2, 6, 9]