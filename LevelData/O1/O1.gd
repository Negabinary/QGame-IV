const WORLD_CHARACTERS = preload("res://Enums/WorldCharacters.gd").WorldCharacters
const CodeBlocks = preload("res://Enums/CodeBlocks.gd").CodeBlocks

var world_path = "res://LevelData/O1/O1World.tscn"

var actors = [
    {"type": WORLD_CHARACTERS.KING, "qubit":0, "goal":0},
	{"type": WORLD_CHARACTERS.ORACLE, "qubit":1, "conditions": {2:true}, "goal":0},
	{"type": WORLD_CHARACTERS.ORACLE, "qubit":3, "conditions": {4:true}, "goal":0},
]

var blocks  = [CodeBlocks.SWORD, CodeBlocks.HADAMARD, CodeBlocks.TIMID_SCOUT, CodeBlocks.CONFIDENT_SCOUT, CodeBlocks.CONSULT_ORACLE]

var initial_state_vector = PoolVector2Array([
	Vector2(0.5,0), Vector2(0,0), Vector2(0,0), Vector2(0,0),
	Vector2(0,0), Vector2(0.5,0), Vector2(0,0), Vector2(0,0),
	Vector2(0,0), Vector2(0,0), Vector2(0,0), Vector2(0,0),
	Vector2(0,0), Vector2(0,0), Vector2(0,0), Vector2(0,0),
	
	Vector2(0,0), Vector2(0.5,0), Vector2(0,0), Vector2(0,0),
	Vector2(0,0.5), Vector2(0,0), Vector2(0,0), Vector2(0,0),
	Vector2(0,0), Vector2(0,0), Vector2(0,0), Vector2(0,0),
	Vector2(0,0), Vector2(0,0), Vector2(0,0), Vector2(0,0),
])

var initial_mosaic_tree = [[0, 1], [2, 3]]

var intitial_mosaic_map = [0, 5, 6, 7]

var description = """
LOADS OF WORLDS!
"""