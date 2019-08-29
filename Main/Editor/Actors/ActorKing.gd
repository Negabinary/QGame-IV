extends ActorKillable
class_name ActorKing

func _init(actor_id, qubit_id, goal=-1).(actor_id, qubit_id, goal):
	icon = load("res://Main/Editor/Actors/Headers/KingIcon.tscn")

func get_actor_sprites(world_id:int, active:bool, code_block_array:Array) -> Array: #of Strings
	var return_string = ""
	if world_id | (1 << qubit_id_neck) == world_id:
		return_string = "On"
	else:
		return_string = "Off"
	if code_block_array[actor_id] is CodeBlocks.CodeBlockSword:
		return_string += "Sword"
	return [return_string]