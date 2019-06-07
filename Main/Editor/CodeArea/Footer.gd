extends HBoxContainer

var actor:Actor

func update_text(probabilities:Array) -> void:
	var actor_id := actor.get_actor_id()
	var current_probability = str(int(probabilities[actor.actor_id]*100+0.5))
	$Current.text = current_probability + "%"
	if actor.has_goal():
		var goal := actor.get_goal()
		var goal_string := str(int(goal*100+0.5)) + "%"
		var goal_satisfied = abs(probabilities[actor_id] - goal) < 0.00001
		$Target.text = goal_string
		if goal_satisfied:
			$Status.text = "True"
		else:
			$Status.text = "False"
	else:
		$Target.text = "No Goal"
		$Status.text = "True"