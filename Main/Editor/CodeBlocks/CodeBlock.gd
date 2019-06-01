class_name CodeBlock

var actor:Dictionary
var actor_id:int
var qubit_id:int


func set_actor(actor_id:int, actor):
	self.actor_id = actor_id
	self.actor = actor
	self.qubit_id = actor.qubit

func filter_affected_worlds(affected_worlds):
	return affected_worlds

func is_condition_met(world_id, posbit, condition_state):
	return (world_id | posbit != world_id) == condition_state

func get_actor_id():
	return actor_id

func get_qubit_id():
	return qubit_id