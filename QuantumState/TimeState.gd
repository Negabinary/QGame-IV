class_name TimeState

var actors
var actions : Actions
var state_vector : StateVector
var qubit_count : int


func _init(actors, state_vector, code_array = null):
	if code_array == null:
		code_array = [null]
		code_array.resize(actors.size())
	self.actors = actors
	self.actions = Actions.new(code_array, actors, state_vector.size())
	self.state_vector = StateVector.new(state_vector)
	self.state_vector =  self.actions.apply_actions(self.state_vector)
	self.qubit_count = round(log(state_vector.size())/log(2))

func calculate_next_state(code_array):
	return get_script().new(
		actors,
		state_vector.get_vector(),
		code_array
	)

func get_affected_worlds():
	return actions.get_affected_worlds(state_vector.get_world_count())

func get_affected_worlds_preview(preview_code_block):
	return actions.get_affected_worlds_preview(state_vector.get_world_count(), preview_code_block)

func get_vector() -> Array:
	return state_vector.get_vector()

func get_state_vector() -> StateVector:
	return state_vector

func get_world_state(world_id) -> Vector2:
	return get_vector()[world_id]

func get_world_count() -> int:
	return get_vector().size()

func get_code_array():
	return actions.get_code_array()

func get_qubit_code_array():
	var actor_code_array = get_code_array()
	var qubit_code_array = []
	for qubit_id in range(qubit_count):
		qubit_code_array += [null]
	for actor_id in range(actor_code_array.size()):
		qubit_code_array[actors[actor_id].qubit] = actor_code_array[actor_id]
	return qubit_code_array

func get_qubit_count():
	return qubit_count

func get_world_probabilities():
	return state_vector.get_world_probabilities()

func get_actor_probability(actor_id):
	var qubit_id = actors[actor_id].qubit
	return state_vector.get_qubit_probability(qubit_id)

func get_forward_matrix() -> SparseMatrix:
	return actions.get_forward_matrix()

func get_backward_matrix() -> SparseMatrix:
	return actions.get_backward_matrix()