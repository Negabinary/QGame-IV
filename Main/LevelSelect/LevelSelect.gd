extends ColorRect

func _ready():
	for button_id in range($VBoxContainer.get_child_count()):
		var button = $VBoxContainer.get_child(button_id)
		button.connect("level_selected", self, "on_level_selected")


signal level_selected

func on_level_selected(level_path):
	emit_signal("level_selected", level_path)
