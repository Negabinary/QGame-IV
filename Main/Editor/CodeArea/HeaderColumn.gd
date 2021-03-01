extends PanelContainer

const HEADER_SCENE = preload("Header.tscn")

func initialise_code_headers(actors:Array):
	for actor in actors:
		var header_instance = actor.get_icon().instance()
		$VBoxContainer/VBoxContainer.add_child(header_instance)
	
	$VBoxContainer/Button.connect("pressed", self, "on_selected")


func set_column_selected(new_state):
	$VBoxContainer/Button.pressed = new_state

signal column_selected

func on_selected():
	if $VBoxContainer/Button.pressed == true:
		emit_signal("column_selected", -1)
	else:
		$VBoxContainer/Button.pressed = true
