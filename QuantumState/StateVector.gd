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

func get_state(world_id:int) -> float:
	return vector[world_id].length()

func get_state_complex(world_id:int) -> Vector2:
	return vector[world_id]

func get_state_squared(world_id:int) -> float:
	return vector[world_id].length_squared()

func get_max_state() -> float:
	var max_state_squared : float = 0
	for state in vector:
		max_state_squared = max(state.length_squared(), max_state_squared)
	return sqrt(max_state_squared)