extends VBoxContainer
class_name Editor

const CODE_BLOCKS := preload("CodeBlocks/CodeBlocks.gd").CodeBlockID

var world_path := "res://Main/Editor/Levels/WorldLevels/005-Guard.tscn"
var initial_state_vector := PoolVector2Array([
	Vector2(0,0), Vector2(1,0), Vector2(0,0), Vector2(0,0)])
var blocks  := [CODE_BLOCKS.SWORD]

var __actor_king := ActorGuardedKing.new(0, 0, 1, 0)
var __actor_guard := ActorGuard.new(1, 1, 0)
var actors := [__actor_king, __actor_guard]

onready var head_column := $CodeArea/VBoxContainer/PanelContainer/HBoxContainer/HeaderColumn
onready var code_columns :=$CodeArea/VBoxContainer/PanelContainer/HBoxContainer/ScrollContainer/CodeColumns
onready var footer_column := $CodeArea/VBoxContainer/PanelContainer/HBoxContainer/FooterColumn
onready var world_viewer := $WorldViewer/WorldViewer
onready var complete_level_button := $CodeArea/VBoxContainer/InterfaceShelf/HBoxContainer2/CompleteLevelButton
onready var code_block_shelf := $CodeArea/VBoxContainer/InterfaceShelf/HBoxContainer2/CodeBlockShelf
onready var back_button := $CodeArea/VBoxContainer/InterfaceShelf/HBoxContainer2/ReturnButton
onready var complete_button := $CodeArea/VBoxContainer/InterfaceShelf/HBoxContainer2/CompleteLevelButton

var initial_state : TimeState

var current_time = 0

#func _ready():
#	initialise()

func initialise() -> void:
	initial_state = TimeState.new(actors, initial_state_vector)
	_initialise_code_area(initial_state)
	world_viewer.initialise_world_viewer(initial_state, world_path, actors)

func _initialise_code_area(initial_state:TimeState) -> void:
	head_column.initialise_code_headers(actors)
	head_column.connect("column_selected", self, "on_code_column_selected")
	
	code_columns.initialise_code_columns(actors, initial_state)
	code_columns.connect("code_block_added", self, "on_code_block_added")
	code_columns.connect("code_block_changed", self, "on_code_block_changed")
	code_columns.connect("code_block_removed", self, "on_code_block_removed")
	code_columns.connect("code_block_preview", self, "on_code_block_preview")
	code_columns.connect("code_block_preview_end", self, "on_code_block_preview_end")
	code_columns.connect("code_column_selected", self, "on_code_column_selected")
	code_columns.connect("code_column_removed", self, "on_code_column_removed")
	back_button.connect("button_up", self, "on_return_to_level_select")
	complete_button.connect("button_up", self, "on_level_complete")
	
	
	_set_up_code_block_shelf(blocks)
	
	footer_column.initialise_code_footers(actors)
	_update_level_progress()


func _set_up_code_block_shelf(code_block_ids:Array) -> void:
	var code_block_since_separator := true
	for node in code_block_shelf.get_children():
		if node is CodeShelfBlock:
			if node.dragging_id in code_block_ids:
				code_block_since_separator = true
				node.show()
			else:
				node.hide()
		elif node is VSeparator:
			if code_block_since_separator == true:
				code_block_since_separator = false
				node.show()
			else:
				node.hide()


func _change_time_instant(new_time:int) -> void:
	if current_time != new_time:
		_ui_change_time(new_time)
		_update_world_viewer_instant()


func _change_time_animate(new_time:int) -> void:
	var difference_matrix:SparseMatrix = GateBuilder.new_identity(initial_state.get_world_count())
	if new_time != current_time:
		var column_range
		if new_time > current_time:
			column_range = range(new_time, current_time, -1)
		elif new_time < current_time:
			column_range = range(new_time + 1, current_time + 1)
		for time in column_range:
				difference_matrix = difference_matrix.multiply(get_state_at_time(time).get_forward_matrix())
		_ui_change_time(new_time)
		_update_world_viewer_animate(difference_matrix)


func _ui_change_time(new_time:int) -> void:
	head_column.set_column_selected(new_time == 0)
	code_columns.select_column(new_time - 1)
	current_time = new_time


func _update_world_viewer_instant() -> void:
	var new_state = get_state_at_time(current_time)
	world_viewer.set_state(new_state)


func _update_world_viewer_animate(difference_matrix: SparseMatrix) -> void:
	var new_state : TimeState = get_state_at_time(current_time)
	world_viewer.apply_matrix(new_state, difference_matrix)


func get_state_at_time(time:int) -> TimeState:
	if time == 0:
		return initial_state
	else:
		return code_columns.get_state(time - 1)


func update_states_from(column_id:int) -> void:
	_change_time_instant(column_id + 1)
	var backward_matrix:SparseMatrix = code_columns.get_backward_matrix(column_id)
	if column_id <= code_columns.get_state_count():
		code_columns.update_states_from(column_id, get_state_at_time(column_id))
	_update_level_progress()
	var forward_matrix:SparseMatrix = code_columns.get_forward_matrix(column_id)
	var difference_matrix:SparseMatrix = backward_matrix.multiply(forward_matrix)
	_update_world_viewer_animate(difference_matrix)


# Poly - 000-Tutorial.tscn::3
func _update_level_progress() -> void:
	var probabilities := _get_final_probabilities()
	footer_column.update_probabilities(probabilities) 
	var is_every_condition_met := _get_is_every_condition_met(probabilities)
	_update_continue_button(is_every_condition_met)


func _get_final_probabilities() -> Array:
	var probabilities := []
	var final_state := get_state_at_time(code_columns.get_child_count()-1)
	for actor_id in actors.size():
		probabilities += [final_state.get_actor_probability(actor_id)]
	return probabilities


func _get_is_every_condition_met(probabilities:Array) -> bool:
	var all_conditions_met := true
	for actor_id in actors.size():
		if actors[actor_id].has_goal():
			if abs(probabilities[actor_id] - actors[actor_id].get_goal()) > 0.00001:
				all_conditions_met = false
				break
	return all_conditions_met


func _update_continue_button(active:bool) -> void:
	if active:
		complete_level_button.flat = false
		complete_level_button.disabled = false
	else:
		complete_level_button.flat = true
		complete_level_button.disabled = true


#SIGNALS
signal return_to_level_select

func on_code_block_added(column_id:int) -> void:
	update_states_from(column_id)

func on_code_block_changed(column_id:int) -> void:
	update_states_from(column_id)

func on_code_block_removed(column_id:int) -> void:
	update_states_from(column_id)

func on_code_block_preview(column_id:int, code_block:CodeBlock) -> void:
	if column_id + 1 < code_columns.get_state_count():
		_change_time_instant(column_id + 1)
	else:
		_change_time_instant(column_id)
	world_viewer.update_previews(code_block)


func on_code_block_preview_end(column_id:int, actor_id:int) -> void:
	world_viewer.update_previews()


func on_code_column_selected(column_id:int) -> void:
	_change_time_animate(column_id + 1)

func on_code_column_removed(column_id:int) -> void:
	if (column_id + 1) <= current_time:
		_ui_change_time(current_time-1)

func on_return_to_level_select() -> void:
	emit_signal("return_to_level_select")

func on_level_complete() -> void:
	emit_signal("return_to_level_select")