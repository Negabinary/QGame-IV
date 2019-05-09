extends HBoxContainer

var actor

func update_text(actor_id, probabilities):
	var current_probability = str(int(probabilities[actor_id]*100+0.5))
	$Current.text = current_probability + "%"
	if actor.has("goal"):
		var goal_probability = str(int(actor.goal*100+0.5))
		$Target.text = goal_probability + "%"
		var goal_satisfied = abs(probabilities[actor_id] - actor.goal) < 0.00001
		if goal_satisfied:
			$Status.text = "True"
		else:
			$Status.text = "False"
	else:
		$Target.text = "No Goal"
		$Status.text = "True"
