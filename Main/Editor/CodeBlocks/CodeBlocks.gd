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
		_:
			return CodeBlockNull.new()


class CodeBlockNull:
	extends CodeBlock
	

class CodeBlockAction:
	extends CodeBlock


class CodeBlockSword:
	extends CodeBlockAction
	var code_block_id = 0
	const texture = preload("Code_Block_Sword.tres")


class CodeBlockHadamard:
	extends CodeBlockAction
	var code_block_id = 1
	const texture = preload("Code_Block_Hadamard.tres")


class CodeBlockCondition:
	extends CodeBlock
	


class CodeBlockTimidScout:
	extends CodeBlockCondition
	var code_block_id = 2
	const texture = preload("Code_Block_Timid_Scout.tres")


class CodeBlockConfidentScout:
	extends CodeBlockCondition
	var code_block_id = 3
	const texture = preload("Code_Block_Confident_Scout.tres")


class CodeBlockConsultOracle:
	extends CodeBlockCondition
	var code_block_id = 4
	const texture = preload("Code_Block_Consult_Oracle.tres")

	"""
	func old_filter_affected_worlds(affected_worlds):
		var oracle_conditions = old_actor.conditions
		for qubit_id in oracle_conditions:
			var filtered_worlds = []
			var posbit = 1 << qubit_id
			for world_id in affected_worlds:
				if is_condition_met(world_id, posbit, oracle_conditions[qubit_id]):
					filtered_worlds += [world_id]
			affected_worlds = filtered_worlds
		return affected_worlds
	"""
