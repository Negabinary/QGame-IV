extends Object
class_name Actor

var actor_id : int
var compatible_code_blocks := []
var icon : PackedScene = load("res://Main/Editor/Actors/Headers/CatIcon.tscn")

func _init(actor_id, goal=-1):
	self.actor_id = actor_id

func can_place_code_block(code_block:CodeBlock) -> bool:
	for compatible_code_block in compatible_code_blocks:
		if code_block is compatible_code_block:
			return true
	return false

func filter_affected_worlds(affected_worlds:Array, code_block:CodeBlock) -> Array:
	return affected_worlds

func get_matrix(code_block:CodeBlock, affected_worlds:Array, world_count:int) -> SparseMatrix:
	return GateBuilder.new_identity(world_count)

func get_actor_sprites(world_id:int, active:bool, code_block_array:Array) -> Array: #of strings
	return []

func get_actor_id() -> int:
	return actor_id

func has_goal() -> bool:
	return false

func get_icon() -> PackedScene:
	return icon