extends Resource
class_name LevelData

const WORLD_CHARACTERS = preload("res://Enums/WorldCharacters.gd")
const CodeBlocks = preload("res://Enums/CodeBlocks.gd").CodeBlocks

var world_path : String
var actors : Dictionary
var initial_state_vector : PoolVector2Array
var description : String
var blocks : Array