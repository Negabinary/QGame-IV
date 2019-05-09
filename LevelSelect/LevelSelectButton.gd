extends Button

export var level_path = ""


func _ready():
	self.connect("button_up", self, "_on_G0_button_up")


signal level_selected

func _on_G0_button_up():
	emit_signal("level_selected", level_path)
	
