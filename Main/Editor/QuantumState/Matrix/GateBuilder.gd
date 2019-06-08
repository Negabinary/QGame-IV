extends Object
class_name GateBuilder

static func new_hadamard(world_count:int, affected_qubit:int, affected_worlds:Array):
	var matrix = SparseMatrix.new(world_count, world_count)
	var posbit = 1 << affected_qubit
	for world_id in range(world_count):
		if world_id in affected_worlds:
			if world_id & posbit != 0:
				matrix.add_value(world_id, world_id, -sqrt(0.5))
			else:
				matrix.add_value(world_id, world_id, sqrt(0.5))
			matrix.add_value(world_id, world_id ^ posbit, sqrt(0.5))
		else:
			matrix.add_value(world_id, world_id, 1)
	return matrix

static func new_not(world_count:int, affected_qubit:int, affected_worlds:Array):
	var matrix = SparseMatrix.new(world_count, world_count)
	var posbit = 1 << affected_qubit
	for world_id in range(world_count):
		if world_id in affected_worlds:
			matrix.add_value(world_id, world_id ^ posbit, 1)
		else:
			matrix.add_value(world_id, world_id, 1)
	return matrix


static func new_identity(world_count:int):
	var matrix = IdentityMatrix.new(world_count, world_count)
	for i in range(world_count):
		matrix.add_value(i, i, 1)
	return matrix

class IdentityMatrix:
	extends SparseMatrix
	
	func _init(x:int, y:int).(x, y):
		pass