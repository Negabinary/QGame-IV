extends Node

class_name CodeBlocks

enum CodeBlockID {SWORD, HADAMARD, TIMID_SCOUT, CONFIDENT_SCOUT, CONSULT_ORACLE}

const CODE_BLOCK_TEXTURES = [
		"res://Graphics/png/sword_square.png",
		"res://Graphics/png/hadamard_square.png",
		"res://Graphics/png/timid_scout_square.png",
		"res://Graphics/png/confindent_scout_square.png",
		"res://Graphics/png/oracle_square.png"
]

static func new_code_block(code_block_id:int = -1) -> CodeBlock:
	match code_block_id:
		-1:
			return CodeBlockNull.new()
		0:
			return CodeBlockSword.new()
		1:
			return CodeBlockHadamard.new()
		2:
			return CodeBlockTimidScout.new()
		3:
			return CodeBlockConfidentScout.new()
		4:
			return CodeBlockConsultOracle.new()


class CodeBlockNull:
	extends CodeBlock
	

class CodeBlockAction:
	extends CodeBlock


class CodeBlockSword:
	extends CodeBlockAction
	
	var code_block_id = 0
	
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
	
	var code_block_id = 1
	
	func get_matrix(world_count:int, affected_worlds:Array) -> SparseMatrix:
		return GateBuilder.new_hadamard(world_count, qubit_id, affected_worlds)


class CodeBlockCondition:
	extends CodeBlock
	


class CodeBlockTimidScout:
	extends CodeBlockCondition
	
	var code_block_id = 2
	
	func filter_affected_worlds(affected_worlds):
		var filtered_worlds = []
		var posbit = 1 << qubit_id
		for world_id in affected_worlds:
			if world_id | posbit != world_id:
				filtered_worlds += [world_id]
		return filtered_worlds


class CodeBlockConfidentScout:
	extends CodeBlockCondition
	
	var code_block_id = 3
	
	func filter_affected_worlds(affected_worlds):
		var filtered_worlds = []
		var posbit = 1 << qubit_id
		for world_id in affected_worlds:
			if world_id | posbit == world_id:
				filtered_worlds += [world_id]
		return filtered_worlds


class CodeBlockConsultOracle:
	extends CodeBlockCondition
	
	var code_block_id = 4
	
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