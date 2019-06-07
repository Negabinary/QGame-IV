const WORLD_CHARACTERS = preload("res://old_actors/WorldCharacters.gd").WorldCharacters
const CodeBlocks = preload("res://CodeBlocks/CodeBlocks.gd").CodeBlockID

var world_path = "res://LevelData/S0/S0World.tscn"

var old_actors = [
    {"type": WORLD_CHARACTERS.KING, "qubit":0, "goal":0},
	{"type": WORLD_CHARACTERS.CAT, "qubit":1},
	{"type": WORLD_CHARACTERS.CAT, "qubit":2}
]

var initial_state_vector = PoolVector2Array([
	Vector2(0.5,0), Vector2(0,0), Vector2(0,0), Vector2(0.5,0),
	Vector2(0,0), Vector2(0.5,0), Vector2(0,0), Vector2(0.5,0),
])

var blocks  = [CodeBlocks.SWORD, CodeBlocks.TIMID_SCOUT, CodeBlocks.CONFIDENT_SCOUT]


var description = """
Good news! This time there's only a 3/4 chance that there's someone at your throat! Not ideal, but better...

We do however know that if they’re attacking you, they’re attacking at least one of your cats too. 

You can use your scouts (binoculars) to check whether a character is safe before sending a soldier somewhere else.

What? No you can't send the soldier and the scout to the same place. If you did that the soldier would just kill the scout...
"""