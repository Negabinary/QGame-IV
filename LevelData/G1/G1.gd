var CODE_BLOCKS = CodeBlocks.CodeBlockID

var world_path = "res://LevelData/G0/G0World.tscn"

var actors = [
    {"type": WORLD_CHARACTERS.WorldCharacters.KING, "qubit":0, "goal":0, "guard":1},
	{"type": WORLD_CHARACTERS.WorldCharacters.GUARD, "qubit":1},
]

var initial_state_vector = PoolVector2Array([
	Vector2(0,0), Vector2(sqrt(2)/2,0), Vector2(0,0), Vector2(sqrt(2)/2,0),
])

var blocks  = [CODE_BLOCKS.SWORD]

var description = """
It's happened again... 

This time your guard seems to be in a superposition of being put to the sword and not being put to the sword.

We could be in either of the two paralell worlds, there is no way to tell, so best to play it safe.

Everything on the timeline happens to all worlds.

We won't worry about this guard any more though, he's expendible.
"""