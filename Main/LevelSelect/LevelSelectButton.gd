extends Button

export var level_scene : PackedScene


func _ready():
	# warning-ignore:return_value_discarded
	self.connect("button_up", self, "_on_G0_button_up")


signal level_selected

func _on_G0_button_up():
	emit_signal("level_selected", level_scene)
	
