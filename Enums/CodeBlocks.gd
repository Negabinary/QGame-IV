extends Node

enum CodeBlocks {SWORD, HADAMARD, TIMID_SCOUT, CONFIDENT_SCOUT, CONSULT_ORACLE}

const CODE_BLOCK_TEXTURES = [
		"res://CodingUI/BlockTextures/SwordBlock.tres",
		"res://CodingUI/BlockTextures/HadamardBlock.tres",
		"res://CodingUI/BlockTextures/TimidScoutBlock.tres",
		"res://CodingUI/BlockTextures/ConfidentScoutBlock.tres",
		"res://CodingUI/BlockTextures/OracleBlock.tres"
]


class CodeBlockNull:
	extends CodeBlock
	
	func _init(actor_id, actor).(actor_id, actor):
		pass
	

class CodeBlockAction:
	extends CodeBlock
	
	func _init(actor_id, actor).(actor_id, actor):
		pass


class CodeBlockSword:
	extends CodeBlockAction
		
	func _init(actor_id, actor).(actor_id, actor):
		pass
	
	func get_paired_world(world_id, affected_worlds):
		var filtered_worlds = get_guard_affected_worlds(affected_worlds)
		if world_id in filtered_worlds:
			return world_id ^ (1 << qubit_id)
		else:
			return world_id
	
	func get_matrix(world_count:int, affected_worlds:Array) -> SparseMatrix:
		var filtered_worlds = get_guard_affected_worlds(affected_worlds)
		return GateBuilder.new_not(world_count, qubit_id, filtered_worlds)
	
	func get_guard_affected_worlds(affected_worlds):
		if actor.has("guard"):
			var filtered_worlds = []
			var guard_qubit = actor.guard
			var guard_posbit = 1 << guard_qubit
			for world_id in affected_worlds:
				if world_id | guard_posbit == world_id:
					filtered_worlds += [world_id]
			return filtered_worlds
		else:
			return affected_worlds


class CodeBlockHadamard:
	extends CodeBlockAction
		
	func _init(actor_id, actor).(actor_id, actor):
		pass
	
	func get_matrix(world_count:int, affected_worlds:Array) -> SparseMatrix:
		return GateBuilder.new_hadamard(world_count, qubit_id, affected_worlds)


class CodeBlockCondition:
	extends CodeBlock
	
	func _init(actor_id, actor).(actor_id, actor):
		pass


class CodeBlockTimidScout:
	extends CodeBlockCondition
		
	func _init(actor_id, actor).(actor_id, actor):
		pass
	
	func filter_affected_worlds(affected_worlds):
		var filtered_worlds = []
		var posbit = 1 << qubit_id
		for world_id in affected_worlds:
			if world_id | posbit != world_id:
				filtered_worlds += [world_id]
		return filtered_worlds


class CodeBlockConfidentScout:
	extends CodeBlockCondition
		
	func _init(actor_id, actor).(actor_id, actor):
		pass
	
	func filter_affected_worlds(affected_worlds):
		var filtered_worlds = []
		var posbit = 1 << qubit_id
		for world_id in affected_worlds:
			if world_id | posbit == world_id:
				filtered_worlds += [world_id]
		return filtered_worlds


class CodeBlockConsultOracle:
	extends CodeBlockCondition
		
	func _init(actor_id, actor).(actor_id, actor):
		pass
	
	func filter_affected_worlds(affected_worlds):
		var oracle_conditions = actor.conditions
		for qubit_id in oracle_conditions:
			var filtered_worlds = []
			var posbit = 1 << qubit_id
			for world_id in affected_worlds:
				if is_condition_met(world_id, posbit, oracle_conditions[qubit_id]):
					filtered_worlds += [world_id]
			affected_worlds = filtered_worlds
		return affected_worlds