extends ActorKillable
class_name ActorOracle

func _init(actor_id, qubit_id_neck, goal=-1).(actor_id, qubit_id_neck, goal):
	icon = load("res://Main/Editor/Actors/Headers/CatIcon.tscn")
	compatible_code_blocks += [CodeBlocks.CodeBlockConsultOracle]


func filter_affected_worlds(affected_worlds:Array, code_block:CodeBlock) -> Array:
	if code_block is CodeBlocks.CodeBlockConsultOracle:
		return _filter_affected_worlds_consult_oracle(affected_worlds)
	else:
		return .filter_affected_worlds(affected_worlds, code_block)


func _filter_affected_worlds_consult_oracle(affected_worlds:Array) -> Array:
	var filtered_worlds := []
	for world_id in affected_worlds:
		if _get_oracle_response(world_id):
			filtered_worlds += [world_id]
	return filtered_worlds


func _get_oracle_response(world_id):
	return false
