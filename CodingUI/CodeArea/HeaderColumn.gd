extends PanelContainer

const HEADER_SCENE = preload("res://CodingUI/CodeArea/Header.tscn")
const WORLD_CHARACTERS = preload("res://Actors/WorldCharacters.gd")

func initialise_code_headers(level_data):
	for actor in level_data.actors:
		var header_instance = WORLD_CHARACTERS.ICONS[actor.type].instance()
		#header_instance.text = str(actor.type)
		$VBoxContainer/VBoxContainer.add_child(header_instance)
	
	$VBoxContainer/Button.connect("toggled", self, "on_selected")


func set_column_selected(new_state):
	$VBoxContainer/Button.pressed = new_state

signal column_selected

func on_selected(new_state):
	if new_state == true:
		emit_signal("column_selected", -1)
	else:
		$VBoxContainer/Button.pressed = true