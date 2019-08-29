extends Actor
class_name ActorKillable

var goal := -1
var qubit_id_neck : int

func _init(actor_id, qubit_id_neck, goal=-1).(actor_id, goal):
	self.goal = goal
	self.qubit_id_neck = qubit_id_neck
	compatible_code_blocks += [
			CodeBlocks.CodeBlockSword, 
			CodeBlocks.CodeBlockHadamard, 
			CodeBlocks.CodeBlockConfidentScout, 
			CodeBlocks.CodeBlockTimidScout]


func filter_affected_worlds(affected_worlds:Array, code_block:CodeBlock) -> Array:
	if code_block is CodeBlocks.CodeBlockConfidentScout:
		return _filter_affected_worlds_confident_scout(affected_worlds)
	elif code_block is CodeBlocks.CodeBlockTimidScout:
		return _filter_affected_worlds_timid_scout(affected_worlds)
	else:
		return .filter_affected_worlds(affected_worlds, code_block)


func _filter_affected_worlds_confident_scout(affected_worlds:Array):
	var filtered_worlds = []
	var posbit := 1 << qubit_id_neck
	for world_id in affected_worlds:
		if world_id | posbit == world_id:
			filtered_worlds += [world_id]
	return filtered_worlds


func _filter_affected_worlds_timid_scout(affected_worlds:Array):
	var filtered_worlds = []
	var posbit := 1 << qubit_id_neck
	for world_id in affected_worlds:
		if world_id | posbit != world_id:
			filtered_worlds += [world_id]
	return filtered_worlds


func get_matrix(code_block:CodeBlock, affected_worlds:Array, world_count:int) -> SparseMatrix:
	if code_block is CodeBlocks.CodeBlockSword:
		return _get_matrix_sword(affected_worlds, world_count)
	elif code_block is CodeBlocks.CodeBlockHadamard:
		return _get_matrix_hadamard(affected_worlds, world_count)
	else:
		return .get_matrix(code_block, affected_worlds, world_count)


func _get_matrix_sword(affected_worlds:Array, world_count:int) -> SparseMatrix:
	return GateBuilder.new_not(world_count, qubit_id_neck, affected_worlds)


func _get_matrix_hadamard(affected_worlds:Array, world_count:int) -> SparseMatrix:
	return GateBuilder.new_hadamard(world_count, qubit_id_neck, affected_worlds)


func get_neck_probability(state_vector:StateVector) -> float:
	return state_vector.get_qubit_probability(qubit_id_neck)


func get_actor_sprites(world_id:int, active:bool, code_block_array:Array) -> Array: #of Strings
	if world_id | (1 << qubit_id_neck) == world_id:
		return ["On"]
	else:
		return ["Off"]


func has_goal() -> bool:
	return goal != -1


func get_goal() -> int:
	return goal


func old_get_qubit_id() -> int:
	return qubit_id_neck