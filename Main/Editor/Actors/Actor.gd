extends Object
class_name Actor

var goal := -1
var qubit_id : int
var actor_id : int
var compatible_code_blocks := [
		CodeBlocks.CodeBlockSword, 
		CodeBlocks.CodeBlockHadamard, 
		CodeBlocks.CodeBlockConfidentScout, 
		CodeBlocks.CodeBlockTimidScout]
var icon : PackedScene = load("/Headers/CatIcon.tscn")

func _init(actor_id, qubit_id, goal=-1):
	self.actor_id = actor_id
	self.qubit_id = qubit_id
	self.goal = goal

func can_place_code_block(code_block:CodeBlock) -> bool:
	for compatible_code_block in compatible_code_blocks:
		if code_block is compatible_code_block:
			return true
	return false

func get_actor_id() -> int:
	return actor_id

func get_qubit_id() -> int:
	return qubit_id

func has_goal() -> bool:
	return goal != -1

func get_goal() -> int:
	return goal

func get_icon() -> PackedScene:
	return icon