const WORLD_CHARACTERS = preload("res://old_actors/WorldCharacters.gd").WorldCharacters
const CodeBlocks = preload("res://CodeBlocks/CodeBlocks.gd").CodeBlockID

var world_path = "res://LevelData/H0/H0World.tscn"

var old_actors = [
    {"type": WORLD_CHARACTERS.KING, "qubit":0, "goal":0},
	{"type": WORLD_CHARACTERS.ENEMY, "qubit":1, "goal":1}
]

var initial_state_vector = PoolVector2Array([
	Vector2(0.5,0), Vector2(0.5,0), Vector2(0.5,0), Vector2(0.5,0),
])

var blocks  = [CodeBlocks.SWORD, CodeBlocks.HADAMARD, CodeBlocks.TIMID_SCOUT, CodeBlocks.CONFIDENT_SCOUT]

var description = """
There may or may not be an ambush on you.
There may or may not be an ambush on your enemy.

Use (H) to guarantee your safety.
"""