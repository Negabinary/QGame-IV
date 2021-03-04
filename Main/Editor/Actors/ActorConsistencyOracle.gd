extends ActorOracle
class_name ActorConsistencyOracle

var qubit_id_brain
var qubit_f_0

func _init(actor_id, qubit_id_neck, qubit_id_brain, qubit_f_0, goal=-1).(actor_id, qubit_id_neck, goal):
	self.qubit_id_brain = qubit_id_brain
	self.qubit_f_0 = qubit_f_0


func get_actor_sprites(world_id:int, active:bool, code_block_array:Array) -> Array: #of Strings
	var return_array
	if world_id | (1 << qubit_id_neck) == world_id:
		return_array = ["On"]
	else:
		return_array = ["Off"]
	if code_block_array[actor_id] is CodeBlocks.CodeBlockConsultOracle:
		if _get_oracle_response(world_id):
			return_array += ["Yes"]
		else:
			return_array += ["No"]
	if _get_oracle_brain(world_id):
		return_array += ["Unsafe"]
		if _get_oracle_f0(world_id):
			return_array += ["FNX"]
		else:
			return_array += ["FX"]
	else:
		return_array += ["Safe"]
		if _get_oracle_f0(world_id):
			return_array += ["F1"]
		else:
			return_array += ["F0"]
	return return_array


func _get_oracle_response(world_id:int) -> bool:
	var bit_brain = _get_oracle_brain(world_id)
	var bit_f_0 = _get_oracle_f0(world_id)
	var bit_neck = 1 << qubit_id_neck | world_id == world_id
	return bit_f_0 != bit_brain if bit_neck else bit_f_0


func _get_oracle_brain(world_id:int) -> bool:
	var posbit_brain:int = 1 << qubit_id_brain
	return world_id | posbit_brain == world_id


func _get_oracle_f0(world_id:int) -> bool:
	var posbit_f0:int = 1 << qubit_f_0
	return world_id | posbit_f0 == world_id
