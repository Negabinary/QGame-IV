extends Resource
class_name LevelData

const WORLD_CHARACTERS = preload("res://Actors/WorldCharacters.gd")
const CodeBlocks = preload("res://CodeBlocks/CodeBlocks.gd").CodeBlockID

var actors : Dictionary
var initial_state_vector : PoolVector2Array
var description : String
var blocks : Array