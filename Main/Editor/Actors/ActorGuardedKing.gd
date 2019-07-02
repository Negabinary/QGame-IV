extends ActorKillable
class_name ActorGuardedKing

var qubit_id_guard : int

func _init(actor_id:int, qubit_id_neck:int, qubit_id_guard:int, goal:=-1).(actor_id, qubit_id_neck, goal):
	self.icon = load("res://Main/Editor/Actors/Headers/KingIcon.tscn")
	self.qubit_id_guard = qubit_id_guard


func get_matrix(code_block:CodeBlock, affected_worlds:Array, world_count:int) -> SparseMatrix:
	if code_block is CodeBlocks.CodeBlockSword:
		return _get_matrix_sword(affected_worlds, world_count)
	else:
		return .get_matrix(code_block, affected_worlds, world_count)


func _get_matrix_sword(affected_worlds:Array, world_count:int) -> SparseMatrix:
	var filtered_worlds = _filter_affected_by_guard(affected_worlds)
	return GateBuilder.new_not(world_count, qubit_id_neck, filtered_worlds)


func _filter_affected_by_guard(affected_worlds:Array) -> Array:
	var filtered_worlds = []
	var posbit := 1 << qubit_id_guard
	for world_id in affected_worlds:
		if world_id | posbit == world_id:
			filtered_worlds += [world_id]
	return filtered_worlds