extends ActorOracle
class_name ActorDishonestOracle

var qubit_id_brain

func _init(actor_id, qubit_id_neck, qubit_id_brain, goal=-1).(actor_id, qubit_id_neck, goal):
	self.qubit_id_brain = qubit_id_brain


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
	else:
		return_array += ["Safe"]
	return return_array


func _get_oracle_response(world_id:int) -> bool:
	return false


func _get_oracle_brain(world_id:int) -> bool:
	var posbit_brain:int = 1 << qubit_id_brain
	return world_id | posbit_brain == world_id