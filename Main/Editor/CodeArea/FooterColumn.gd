extends PanelContainer

const FOOTER_SCENE = preload("Footer.tscn")


func initialise_code_footers(actors):
	for actor in actors:
		var footer_instance = FOOTER_SCENE.instance()
		footer_instance.actor = actor
		$VBoxContainer/VBoxContainer.add_child(footer_instance)

func update_probabilities(probabilities):
	for actor_id in range(len(probabilities)):
		$VBoxContainer/VBoxContainer.get_child(actor_id).update_text(actor_id, probabilities)