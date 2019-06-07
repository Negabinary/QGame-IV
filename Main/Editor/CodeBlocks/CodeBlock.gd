class_name CodeBlock

var actor


func set_actor(actor):
	self.actor = actor

func filter_affected_worlds(affected_worlds):
	return affected_worlds

func is_condition_met(world_id, posbit, condition_state):
	return (world_id | posbit != world_id) == condition_state

func get_actor_id():
	return actor.get_actor_id()

func get_qubit_id():
	return actor.get_qubit_id()
