extends LevelData

var world_path = "res://LevelData/B1/B1World.tscn"

var old_actors = [
    {"type": WORLD_CHARACTERS.KING, "qubit":0, "goal":0},
	{"type": WORLD_CHARACTERS.KING, "qubit":1},
	{"type": WORLD_CHARACTERS.KING, "qubit":2, "goal": 1}
]

var initial_state_vector = PoolVector2Array([
	Vector2(0.5,0), Vector2(0,0), Vector2(0,0), Vector2(0.5,0),
	Vector2(0,0), Vector2(0.5,0), Vector2(0,0), Vector2(0.5,0),
])

var description = """
You must learn to stop drinking so much, you're going to regret playing a game of quantum Russian roulette with one of your nobles. 

Get out of this mess and make sure the noble pays for this. 
"""