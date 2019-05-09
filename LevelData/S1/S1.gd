const WORLD_CHARACTERS = preload("res://Enums/WorldCharacters.gd").WorldCharacters
const CodeBlocks = preload("res://Enums/CodeBlocks.gd").CodeBlocks

var world_path = "res://LevelData/S1/S1World.tscn"

var actors = [
    {"type": WORLD_CHARACTERS.KING, "qubit":0, "goal":0},
	{"type": WORLD_CHARACTERS.CAT, "qubit":1},
	{"type": WORLD_CHARACTERS.BARON, "qubit":2, "goal":1}
]

var initial_state_vector = PoolVector2Array([
	Vector2(0,0), Vector2(sqrt(2)/2,0), Vector2(0,0), Vector2(0,0),
	Vector2(sqrt(2)/2,0), Vector2(0,0), Vector2(0,0), Vector2(0,0),
])

var blocks  = [CodeBlocks.SWORD, CodeBlocks.TIMID_SCOUT, CodeBlocks.CONFIDENT_SCOUT]

var description = """
After a night out, you regret playing a game of quantum Russian roulette with one of your nobles. 

Get out of this mess and make sure the noble pays for this. 
"""