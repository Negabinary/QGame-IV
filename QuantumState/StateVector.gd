class_name StateVector

var vector : PoolVector2Array

func _init(state_vector: PoolVector2Array):
	assert(typeof(state_vector) == TYPE_VECTOR2_ARRAY)
	self.vector = state_vector

func copy():
	return get_script().new(vector)

func get_world_count():
	return len(vector)

func get_vector():
	return vector

func apply_small_matrix(small_matrix, affected_qubit, affected_worlds):
	var posbit = 1 << affected_qubit
	for world_id in affected_worlds:
		if (world_id | posbit != world_id):
			var old_off_state = vector[world_id ^ posbit]
			var old_on_state = vector[world_id]
			vector[world_id ^ posbit] = multiply_complex(old_off_state, small_matrix[0][0]) + multiply_complex(old_on_state, small_matrix[0][1])
			vector[world_id] = multiply_complex(old_off_state, small_matrix[1][0]) + multiply_complex(old_on_state, small_matrix[1][1])
		
func multiply_complex(vec1, vec2):
	return Vector2(vec1.x * vec2.x - vec1.y * vec2.y, vec1.x * vec2.y + vec1.y * vec2.x)

func get_qubit_probability(qubit_id):
	var posbit = 1 << qubit_id
	var sum = 0
	for world_id in range(get_world_count()):
		if (world_id | posbit == world_id):
			sum += vector[world_id].length_squared()
	return sum

func get_world_probabilities():
	var probabilities = []
	for world_state in vector:
		probabilities += [world_state.length_squared()]
	return probabilities