const StateVector = preload("res://QuantumState/StateVector.gd")

var tree
var map
var state_vector


func _init(state_vector, tree, map):
	self.tree = tree
	self.map = map
	self.state_vector = StateVector.new(state_vector)

func copy():
	#TODO: Copy the tree properly
	var new_map = []
	for i in map:
		new_map += [i]
	var new_vector = state_vector.get_vector()
	return get_script().new(new_vector,tree, new_map)

func apply_small_matrix(small_matrix, affected_qubit, affected_worlds):
	var posbit = 1 << affected_qubit
	var new_map = range(map.size())
	for map_item in range(map.size()):
		if map[map_item] in affected_worlds:
			assert(small_matrix[0][1].length_squared() >= 0.9999) # Alternatives aren't implemented yet...
			new_map[map_item] = posbit ^ map[map_item]
		else:
			new_map[map_item] = map[map_item]
	map = new_map
	state_vector.apply_small_matrix(small_matrix, affected_qubit, affected_worlds)

func get_mosaic_tree():
	return tree

func get_mosaic_map():
	return map

func get_vector():
	return state_vector.get_vector()

func get_world_count():
	return state_vector.get_world_count()

func get_qubit_probability(qubit_id):
	return state_vector.get_qubit_probability(qubit_id)