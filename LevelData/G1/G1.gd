const WORLD_CHARACTERS = preload("res://Enums/WorldCharacters.gd").WorldCharacters
const CodeBlocks = preload("res://Enums/CodeBlocks.gd").CodeBlocks

var world_path = "res://LevelData/G0/G0World.tscn"

var actors = [
    {"type": WORLD_CHARACTERS.KING, "qubit":0, "goal":0, "guard":1},
	{"type": WORLD_CHARACTERS.GUARD, "qubit":1},
]

var initial_state_vector = PoolVector2Array([
	Vector2(0,0), Vector2(sqrt(2)/2,0), Vector2(0,0), Vector2(sqrt(2)/2,0),
])

var blocks  = [CodeBlocks.SWORD]

var initial_mosaic_tree = [[0, 1], [2, 3]]

var intitial_mosaic_map = [0, 5, 6, 7]

var description = """
It's happened again... 

This time your guard seems to be in a superposition of being put to the sword and not being put to the sword.

We could be in either of the two paralell worlds, there is no way to tell, so best to play it safe.

Everything on the timeline happens to all worlds.

We won't worry about this guard any more though, he's expendible.
"""