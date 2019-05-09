extends VBoxContainer

const WORLD_CHARACTERS = preload("res://Enums/WorldCharacters.gd")
const Actions = preload("res://QuantumState/Actions.gd")
const TimeState = preload("res://QuantumState/TimeState.gd")

var head_column
var code_columns
var footer_column
var world_viewer
var complete_level_button

var level_data

var actors
var initial_state_vector
var initial_state
var world_path

var current_time = 0


func _ready():
	head_column = $CodeArea/VBoxContainer/PanelContainer/HBoxContainer/HeaderColumn
	code_columns = $CodeArea/VBoxContainer/PanelContainer/HBoxContainer/ScrollContainer/CodeColumns
	footer_column = $CodeArea/VBoxContainer/PanelContainer/HBoxContainer/FooterColumn
	world_viewer = $HBoxContainer/WorldViewerContainer/WorldViewer
	complete_level_button = $CodeArea/VBoxContainer/CodeBlockShelf/HBoxContainer2/CompleteLevelButton
	

func initialise(level_data_path):
	level_data = load(level_data_path).new()
	actors = level_data.actors
	initial_state_vector = level_data.initial_state_vector
	initial_state = TimeState.new(level_data.actors, level_data.initial_state_vector)
	world_path = level_data.world_path
	
	$HBoxContainer/PanelContainer/VBoxContainer/Label.text = level_data.description
	
	head_column.initialise_code_headers(level_data)
	head_column.connect("column_selected", self, "on_code_column_selected")
	code_columns.initialise_code_columns(level_data, initial_state)
	code_columns.connect("code_block_added", self, "on_code_block_added")
	code_columns.connect("code_block_changed", self, "on_code_block_changed")
	code_columns.connect("code_block_removed", self, "on_code_block_removed")
	code_columns.connect("code_block_preview", self, "on_code_block_preview")
	code_columns.connect("code_block_preview_end", self, "on_code_block_preview_end")
	code_columns.connect("code_column_selected", self, "on_code_column_selected")
	code_columns.connect("code_column_removed", self, "on_code_column_removed")
	footer_column.initialise_code_footers(level_data)
	update_final_probabilities()
	world_viewer.initialise_world_viewer(initial_state, world_path)



func change_time(new_time):
	head_column.set_column_selected(new_time == 0)
	code_columns.select_column(new_time - 1)
	current_time = new_time
	update_world_container()


func update_world_container(preview=null, change=null):
	var new_state = get_state_at_time(current_time)
	world_viewer.set_state(new_state, preview, change)


func get_state_at_time(time):
	if time == 0:
		return initial_state
	else:
		return code_columns.get_state(time - 1)


func update_states_from(column_id):
	if column_id <= code_columns.get_state_count():
		code_columns.update_states_from(column_id, get_state_at_time(column_id))
	

func update_final_probabilities():
	var probabilities = []
	var final_state = get_state_at_time(code_columns.get_child_count()-1)
	var all_conditions_met = true
	for actor_id in range(actors.size()):
		probabilities += [final_state.get_actor_probability(actor_id)]
		if actors[actor_id].has("goal"):
			if abs(probabilities[actor_id] - actors[actor_id].goal) > 0.00001:
				all_conditions_met = false
	if all_conditions_met:
		complete_level_button.flat = false
		complete_level_button.disabled = false
	else:
		complete_level_button.flat = true
		complete_level_button.disabled = true
	footer_column.update_probabilities(probabilities) 


#SIGNALS
signal return_to_level_select

"""
signal code_block_added
signal code_block_changed
signal code_block_removed
signal code_block_preview
signal code_block_preview_end
signal code_column_selected
signal code_column_to_be_removed
"""

func on_code_block_added(column_id, actor_id, mt_code_block):
	var code_block = Actions.mt_code_to_code_block(mt_code_block, actor_id, actors[actor_id])
	update_states_from(column_id)
	change_time(column_id + 1)
	update_world_container()
	update_final_probabilities()
	update_world_container(null, code_block)


func on_code_block_changed(column_id, actor_id, mt_code_block):
	update_states_from(column_id)
	change_time(column_id + 1)
	update_world_container()
	update_final_probabilities()

func on_code_block_removed(column_id, actor_id):
	update_states_from(column_id)
	change_time(column_id + 1)
	update_world_container()
	update_final_probabilities()

func on_code_block_preview(column_id, actor_id, mt_code_block):
	var code_block = Actions.mt_code_to_code_block(mt_code_block, actor_id, actors[actor_id])
	change_time(column_id + 1)
	update_world_container(code_block)

func on_code_block_preview_end(column_id, actor_id):
	update_world_container()

func on_code_column_selected(column_id):
	change_time(column_id + 1)

func on_code_column_removed(column_id):
	update_states_from(column_id)
	if (column_id + 1) <= current_time:
		change_time(current_time-1)
	update_world_container()
	update_final_probabilities()

func on_return_to_level_select():
	emit_signal("return_to_level_select")

func on_level_complete():
	emit_signal("return_to_level_select")