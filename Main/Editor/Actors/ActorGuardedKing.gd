extends ActorKillable
class_name ActorGuardedKing

var guard_id : int

func _init(actor_id:int, qubit_id:int, guard_id:int, goal:=-1).(actor_id, qubit_id, goal):
	self.icon = load("res://Main/Editor/Actors/Headers/KingIcon.tscn")
	self.guard_id = guard_id


func old_get_guard_id() -> int:
	return guard_id