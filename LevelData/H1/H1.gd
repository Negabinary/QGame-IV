const WORLD_CHARACTERS = preload("res://Enums/WorldCharacters.gd").WorldCharacters
const CodeBlocks = preload("res://Enums/CodeBlocks.gd").CodeBlocks

var world_path = "res://LevelData/H1/H1World.tscn"

var actors = [
    {"type": WORLD_CHARACTERS.KING, "qubit":0, "goal":0},
	{"type": WORLD_CHARACTERS.ENEMY, "qubit":1, "goal":1},
	{"type": WORLD_CHARACTERS.ENEMY, "qubit":2, "goal":1}
]

var initial_state_vector = PoolVector2Array([
	Vector2(sqrt(0.125),0), Vector2(sqrt(0.125),0), Vector2(0.5,0), Vector2(0,0),
	Vector2(sqrt(0.125),0), Vector2(-sqrt(0.125),0), Vector2(0,0), Vector2(0.5,0),
])

var blocks  = [CodeBlocks.SWORD, CodeBlocks.HADAMARD, CodeBlocks.TIMID_SCOUT, CodeBlocks.CONFIDENT_SCOUT]

var initial_mosaic_tree = [[0,1],[[2,3],[4,5]]]

var intitial_mosaic_map = [2,7,0,1,4,5]

var description = """
This one is just a quantum mess. Pay attention to the signs on each parallel world's value.
"""