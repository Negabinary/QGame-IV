class_name Actions

const CODE_BLOCKS = preload("res://Enums/CodeBlocks.gd").CodeBlocks
const CodeBlocks = preload("res://Enums/CodeBlocks.gd")

var total_matrix : SparseMatrix
var total_matrix_inverse : SparseMatrix
var code_array := []
var code_block_array := []


func _init(code_array, actors, world_count):
	self.code_array = code_array
	self.code_block_array = _mt_code_array_to_code_block_array(code_array, actors)
	self.total_matrix = calculate_total_matrix(world_count)
	self.total_matrix_inverse = self.total_matrix

func _mt_code_array_to_code_block_array(code_array, actors):
	var code_block_array = []
	for actor_id in range(0, code_array.size()):
		var code_block = code_array[actor_id]
		code_block_array += [mt_code_to_code_block(code_block, actor_id, actors[actor_id])]
	return code_block_array

static func mt_code_to_code_block(old_code, actor_id, actor):
	match old_code:
		CODE_BLOCKS.SWORD:
			return CodeBlocks.CodeBlockSword.new(actor_id, actor)
		CODE_BLOCKS.HADAMARD:
			return CodeBlocks.CodeBlockHadamard.new(actor_id, actor)
		CODE_BLOCKS.CONFIDENT_SCOUT:
			return CodeBlocks.CodeBlockConfidentScout.new(actor_id, actor)
		CODE_BLOCKS.TIMID_SCOUT:
			return CodeBlocks.CodeBlockTimidScout.new(actor_id, actor)
		CODE_BLOCKS.CONSULT_ORACLE:
			return CodeBlocks.CodeBlockConsultOracle.new(actor_id, actor)
		null:
			return CodeBlocks.CodeBlockNull.new(actor_id, actor)

func calculate_total_matrix(world_count : int) -> SparseMatrix:
	var affected_worlds : Array = get_affected_worlds(world_count)
	var total_matrix : SparseMatrix = GateBuilder.new_identity(world_count)
	for code_block in code_block_array:
		if code_block is CodeBlocks.CodeBlockAction:
			total_matrix = total_matrix.multiply(code_block.get_matrix(world_count, affected_worlds))
			
	return total_matrix


func get_affected_worlds(world_count):
	var affected_worlds = []
	for world_id in range(0, world_count):
		affected_worlds += [world_id]
	for code_block in code_block_array:
		affected_worlds = code_block.filter_affected_worlds(affected_worlds)
	return affected_worlds

func get_affected_worlds_preview(world_count, preview_code_block):
	var preview_actor_id = preview_code_block.get_actor_id()
	var replaced_block = code_block_array[preview_actor_id]
	code_block_array[preview_actor_id] = preview_code_block
	var affected_worlds_with_preview = get_affected_worlds(world_count)
	code_block_array[preview_actor_id] = replaced_block
	return affected_worlds_with_preview

func apply_actions(state_vector : StateVector) -> StateVector:
	return total_matrix.multiply_vector(state_vector)

func get_code_array():
	return code_array

func get_code_block_array():
	return code_block_array

func get_forward_matrix() -> SparseMatrix:
	return total_matrix

func get_backward_matrix() -> SparseMatrix:
	return total_matrix_inverse