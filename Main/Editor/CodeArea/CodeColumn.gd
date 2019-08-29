extends PanelContainer

class_name CodeColumn

const DROP_AREA_SCENE = preload("DropArea.tscn")

var state : TimeState
var column_no : int
var end_column = true


func _process(delta):
	if not end_column:
		if _is_empty():
			if not _is_mouse_over():
				on_column_to_be_removed()

func _is_empty():
	var code_array = get_code_array()
	var is_empty = true
	for i in code_array:
		if not i is CodeBlocks.CodeBlockNull:
			is_empty = false
			break
	return is_empty

func _is_mouse_over():
	return get_global_rect().has_point(get_global_mouse_position())


func initialise(actors:Array, column_no:int) -> void:
	set_column_no(column_no)
	for actor in actors:
		add_drop_area(actor)
	$VBoxContainer/HBoxContainer/SelectButton.connect("toggled", self, "on_select_button_toggled")
	$VBoxContainer/HBoxContainer/RemoveButton.connect("button_up", self, "on_column_to_be_removed")


func add_drop_area(actor:Actor) -> void:
	var drop_area = DROP_AREA_SCENE.instance()
	drop_area.initialise(actor)
	drop_area.connect("block_added", self, "on_block_added")
	drop_area.connect("block_changed", self, "on_block_changed")
	drop_area.connect("block_removed", self, "on_block_removed")
	drop_area.connect("block_preview", self, "on_block_preview")
	drop_area.connect("block_preview_end", self, "on_block_preview_end")
	$VBoxContainer/VBoxContainer.add_child(drop_area)


func get_code_array():
	var code_array = []
	for drop_area in $VBoxContainer/VBoxContainer.get_children():
		code_array += [drop_area.get_code_block()]
	return code_array


func get_state():
	return state


func update_state(previous_state):
	state = previous_state.calculate_next_state(get_code_array())
	state.set_time(column_no)
	return state


func set_select_button(new_state):
	$VBoxContainer/HBoxContainer/SelectButton.pressed = new_state


func get_forward_matrix() -> SparseMatrix :
	return state.get_forward_matrix()


func get_backward_matrix() -> SparseMatrix:
	return state.get_backward_matrix()


func set_column_no(column_no:int) -> void:
	self.column_no = column_no
	if state:
		state.set_time(column_no)
	$VBoxContainer/HBoxContainer/SelectButton.text = str(column_no)


signal block_added
signal block_changed
signal block_removed
signal block_preview
signal block_preview_end
signal column_selected
signal column_to_be_removed

func on_block_added(actor_id, code_block):
	if end_column:
		_activate_column()
	emit_signal("block_added", get_index(), actor_id, code_block)

func _activate_column():
	end_column = false
	$VBoxContainer/HBoxContainer/SelectButton.disabled = false
	$VBoxContainer/HBoxContainer/RemoveButton.disabled = false

func on_block_changed(actor_id, code_block):
	emit_signal("block_changed", get_index(), actor_id, code_block)

func on_block_removed(actor_id):
	emit_signal("block_removed", get_index(), actor_id)

func on_block_preview(actor_id, code_block):
	emit_signal("block_preview", get_index(), actor_id, code_block)

func on_block_preview_end(actor_id):
	emit_signal("block_preview_end", get_index(), actor_id)

func on_column_to_be_removed():
	emit_signal("column_to_be_removed", get_index())

func on_select_button_toggled(new_state):
	if new_state == true:
		emit_signal("column_selected", get_index())
	else:
		$VBoxContainer/HBoxContainer/SelectButton.pressed = true