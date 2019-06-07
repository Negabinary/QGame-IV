extends HBoxContainer

const CODE_COLUMN = preload("CodeColumn.tscn")

var actors : Array
var initial_state : TimeState


func initialise_code_columns(actors:Array, initial_state:TimeState) -> void:
	self.actors = actors
	self.initial_state = initial_state
	insert_column(0)


func insert_column(time):
	var code_column = CODE_COLUMN.instance()
	code_column.initialise(actors, time + 1)
	code_column.update_state(get_state(time-1))
	code_column.connect("block_added", self, "on_block_added")
	code_column.connect("block_changed", self, "on_block_changed")
	code_column.connect("block_removed", self, "on_block_removed")
	code_column.connect("block_preview", self, "on_block_preview")
	code_column.connect("block_preview_end", self, "on_block_preview_end")
	code_column.connect("column_selected", self, "on_column_selected")
	code_column.connect("column_to_be_removed", self, "on_column_to_be_removed")
	add_child(code_column)
	move_child(code_column,time)


func remove_column(column_id):
	remove_child(get_child(column_id))
	for i in range(max(0, column_id), get_child_count()):
		get_child(i).set_column_no(i+1)


func select_column(column_id):
	for i in range(get_child_count()):
		if i == column_id:
			get_child(i).set_select_button(true)
		else:
			get_child(i).set_select_button(false)


func update_states_from(column_id, first_state):
	var previous_state = first_state
	for i in range(max(0, column_id), get_child_count()):
		previous_state = get_child(i).update_state(previous_state)


func get_state(column_id):
	if column_id < 0 or column_id >= get_child_count():
		return initial_state
	else:
		return get_child(column_id).get_state()


func get_state_count():
	return get_child_count()


func get_forward_matrix(column_id : int) -> SparseMatrix:
	return get_child(column_id).get_forward_matrix()


func get_backward_matrix(column_id : int) -> SparseMatrix:
	return get_child(column_id).get_backward_matrix()


signal code_block_added
signal code_block_changed
signal code_block_removed
signal code_block_preview
signal code_block_preview_end
signal code_column_selected
signal code_column_removed


func on_block_added(column_id, actor_id, code_block):
	if column_id == get_child_count() - 1:
		insert_column(column_id + 1)
	emit_signal("code_block_added", column_id)

func on_block_changed(column_id, actor_id, code_block):
	emit_signal("code_block_changed", column_id)

func on_block_removed(column_id, actor_id):
	emit_signal("code_block_removed", column_id)

func on_block_preview(column_id, actor_id, code_block:CodeBlock):
	emit_signal("code_block_preview", column_id, code_block)

func on_block_preview_end(column_id, actor_id):
	emit_signal("code_block_preview_end", column_id, actor_id)

func on_column_selected(column_id):
	emit_signal("code_column_selected", column_id)

func on_column_to_be_removed(column_id):
	remove_column(column_id)
	emit_signal("code_column_removed", column_id)