const WORLD_CHARACTERS = preload("res://old_actors/WorldCharacters.gd").WorldCharacters
const CodeBlocks = preload("res://CodeBlocks/CodeBlocks.gd").CodeBlockID

var world_path = "res://LevelData/H1/H1World.tscn"

var old_actors = [
    {"type": WORLD_CHARACTERS.KING, "qubit":0, "goal":0},
	{"type": WORLD_CHARACTERS.ENEMY, "qubit":1, "goal":1},
	{"type": WORLD_CHARACTERS.ENEMY, "qubit":2, "goal":1}
]

var initial_state_vector = PoolVector2Array([
	Vector2(sqrt(0.125),0), Vector2(sqrt(0.125),0), Vector2(0.5,0), Vector2(0,0),
	Vector2(sqrt(0.125),0), Vector2(-sqrt(0.125),0), Vector2(0,0), Vector2(0.5,0),
])

var blocks  = [CodeBlocks.SWORD, CodeBlocks.HADAMARD, CodeBlocks.TIMID_SCOUT, CodeBlocks.CONFIDENT_SCOUT]

var description = """
This one is just a quantum mess. Pay attention to the signs on each parallel world's value.
"""