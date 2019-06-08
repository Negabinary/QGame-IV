class_name Actions

var actors : Array
var total_matrix : SparseMatrix
var total_matrix_inverse : SparseMatrix
var code_block_array := []


func _init(code_block_array, world_count, actors):
	self.actors = actors
	self.code_block_array = code_block_array
	self.total_matrix = calculate_total_matrix(world_count)
	self.total_matrix_inverse = self.total_matrix


func calculate_total_matrix(world_count : int) -> SparseMatrix:
	var affected_worlds : Array = get_affected_worlds(world_count)
	var total_matrix : SparseMatrix = GateBuilder.new_identity(world_count)
	for actor_id in code_block_array.size():
		var actor:Actor = actors[actor_id]
		var code_block = code_block_array[actor_id]
		var block_matrix = actor.get_matrix(code_block, affected_worlds, world_count)
		if not block_matrix is GateBuilder.IdentityMatrix:
			total_matrix = total_matrix.multiply(block_matrix)
	return total_matrix


func get_affected_worlds(world_count):
	var affected_worlds = []
	for world_id in range(0, world_count):
		affected_worlds += [world_id]
	for actor_id in code_block_array.size():
		var actor:Actor = actors[actor_id]
		var code_block = code_block_array[actor_id]
		affected_worlds = actor.filter_affected_worlds(affected_worlds, code_block)
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

func get_code_block_array():
	return code_block_array

func get_forward_matrix() -> SparseMatrix:
	return total_matrix

func get_backward_matrix() -> SparseMatrix:
	return total_matrix_inverse