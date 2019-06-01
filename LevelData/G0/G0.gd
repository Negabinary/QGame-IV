var CODE_BLOCKS := CodeBlocks.CodeBlockID

var world_path = "res://LevelData/G0/G0World.tscn"

var actors = [
    {"type": WORLD_CHARACTERS.WorldCharacters.KING, "qubit":0, "goal":0, "guard":1},
	{"type": WORLD_CHARACTERS.WorldCharacters.GUARD, "qubit":1, "goal": 0},
]

var initial_state_vector = PoolVector2Array([
	Vector2(0,0), Vector2(1,0), Vector2(0,0), Vector2(0,0),
])

var blocks  = [CODE_BLOCKS.SWORD]

var description = """
Great King, it appears there's someone at your throat.

Usually you would just send in one of your soldiers to get rid of the first person they see, but one of your guards is stationed outside and is under instruction not to let anyone in. No-one can come to your help unless there's someone at the guard's throat.

Drag a few of the (sword) icons on to the timeline at the bottom and hopefully both you and your guard can get out safe.
"""