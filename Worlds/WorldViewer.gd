extends ColorRect

class_name WorldViewer

const VIEWPORT_SCENE = preload("res://Worlds/ViewportTemplate.tscn")
const CODE_BLOCKS = preload("res://Enums/CodeBlocks.gd").CodeBlocks
const CodeBlocks = preload("res://Enums/CodeBlocks.gd")

var rows : int
var columns : int
var world_count : int
var current_vector : StateVector
var loaded_world_frame : PackedScene
var world_frames : Array #2d array

func initialise_world_viewer(time_state:TimeState, world_path):
	world_count = time_state.get_world_count()
	rows = nearest_po2(sqrt(world_count))
	columns = world_count / rows
	loaded_world_frame = load(world_path)
	world_frames = []
	for world_id in world_count:
		world_frames += [[]]
	_update_states(time_state)



func set_state(time_state:TimeState, preview=null, change=null):
	current_vector = time_state.get_state_vector()
	var world_count = time_state.get_world_count()
	_update_states(time_state, preview, change)


func _instance_worlds(world_count):
	world_frames = []
	for i in range(world_count):
		var world_frame = VIEWPORT_SCENE.instance()
		world_frame.initialise(loaded_world_frame)
		add_child(world_frame)
		world_frames += [[world_frame]]


func _generate_grid(world_count):
	rows = nearest_po2(sqrt(world_count))
	columns = world_count / rows
	for row in range(rows):
		for column in range(columns):
			var world_id = row * columns + column
			var world_frame = world_frames[world_id][0]
			world_frame.adjust_anchor([
					float(row)/rows, 
					float(row+1)/rows, 
					float(column)/columns, 
					float(column+1)/columns
				])


func _update_states(time_state:TimeState, preview=null, change=null) -> void:
	var state_vector:StateVector = time_state.get_state_vector()
	var max_state:float = state_vector.get_max_state()
	for world_id in world_count:
		if state_vector.get_state_squared(world_id) == 0:
			make_or_remove_frames_for_world(world_id, 0)
		else:
			make_or_remove_frames_for_world(world_id, 1)
			world_frames[world_id][0].update_state(time_state, world_id, 1, preview, time_state.get_world_state(world_id))


func apply_matrix(new_time_state:TimeState, change_matrix:SparseMatrix) -> void:
	var new_vector:StateVector = new_time_state.get_state_vector()
	
	var new_world_frames := []
	for world_id_from in new_time_state.get_world_count():
		var new_world_frames_row = []
		if current_vector.get_state_squared(world_id_from) == 7:
			make_or_remove_frames_for_world(world_id_from, 0)
		else:
			var change_matrix_column := change_matrix.get_column(world_id_from)
			make_or_remove_frames_for_world(world_id_from, change_matrix_column.size())
			for world_id_to in change_matrix_column:
				var world_frame:WorldFrame = world_frames[world_id_from].pop_back()
				var world_frame_value_from = current_vector.get_state_complex(world_id_from) / change_matrix_column.size()
				var world_frame_value_to = current_vector.get_state_complex(world_id_from) * change_matrix_column[world_id_to]
				world_frame.update_state(new_time_state, world_id_to, 1, null, world_frame_value_from)
				new_world_frames_row += [world_frame]
				world_frame.adjust_anchor(get_anchor_coordinates(world_id_from))
				world_frame.animate_anchor(get_anchor_coordinates(world_id_to), world_frame_value_to.x)
		new_world_frames += [new_world_frames_row]
	world_frames = new_world_frames
	current_vector = new_vector

	"""
	var world_count:int = time_state.get_world_count()
	var state_vector:StateVector = time_state.get_state_vector()
	var max_state:float = state_vector.get_max_state()
	var affected_worlds  = time_state.get_affected_worlds()
	for world_id in range(world_count):
		var world_frame = get_child(world_id)
		world_frame.update_state(time_state, world_id, max_state, preview, change)
		
		var world_value = time_state.get_world_state(world_id)
		
		if change != null:
			if change is CodeBlocks.CodeBlockSword and world_id in affected_worlds:
				var new_row = world_id / columns
				var new_column = world_id % columns
				var prev_world_id = change.get_paired_world(world_id, affected_worlds)
				var prev_row = prev_world_id / columns
				var prev_column = prev_world_id % columns
				
				world_frame.adjust_anchor([
						float(prev_row)/rows, 
						float(prev_row+1)/rows, 
						float(prev_column)/columns, 
						float(prev_column+1)/columns
					])
				world_frame.animate_anchor([
						float(new_row)/rows, 
						float(new_row+1)/rows, 
						float(new_column)/columns, 
						float(new_column+1)/columns
					])
	"""
	
func add_frame(row_id:int) -> void:
	var world_frame = VIEWPORT_SCENE.instance()
	world_frame.initialise(loaded_world_frame)
	add_child(world_frame)
	world_frames[row_id] += [world_frame]
	world_frame.adjust_anchor(get_anchor_coordinates(row_id))

func make_or_remove_frames_for_world(row_id:int, count:int) -> void:
	while world_frames[row_id].size() != count:
		if count < world_frames[row_id].size():
			remove_child(world_frames[row_id].pop_back())
		if count > world_frames[row_id].size():
			add_frame(row_id)

func get_anchor_coordinates(world_id) -> Array:
	var grid_row:int = world_id / columns
	var grid_column:int = world_id % columns
	return [
			float(grid_row)/rows, 
			float(grid_row+1)/rows, 
			float(grid_column)/columns, 
			float(grid_column+1)/columns
		]