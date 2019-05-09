extends ColorRect

const VIEWPORT_SCENE = preload("res://Worlds/ViewportTemplate.tscn")
const CODE_BLOCKS = preload("res://Enums/CodeBlocks.gd").CodeBlocks
const CodeBlocks = preload("res://Enums/CodeBlocks.gd")

var rows
var columns

func initialise_world_viewer(time_state, world_path):
	var world_count = time_state.get_world_count()
	_instance_worlds(world_count, world_path)
	_generate_grid(world_count)
	_update_states(time_state)


func set_state(time_state, preview=null, change=null):
	_update_states(time_state, preview, change)


func _instance_worlds(world_count, world_path):
	var loaded_world = load(world_path)
	for i in range(world_count):
		var world_frame = VIEWPORT_SCENE.instance()
		world_frame.initialise(loaded_world)
		add_child(world_frame)


func _generate_grid(world_count):
	rows = nearest_po2(sqrt(world_count))
	columns = world_count / rows
	for row in range(rows):
		for column in range(columns):
			var world_id = row * columns + column
			var world_frame = get_child(world_id)
			world_frame.adjust_anchor([
					float(row)/rows, 
					float(row+1)/rows, 
					float(column)/columns, 
					float(column+1)/columns
				])


func _update_states(time_state, preview=null, change=null):
	var world_count = time_state.get_world_count()
	var max_state = _get_max_state(time_state)
	var affected_worlds = time_state.get_affected_worlds()
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


func _get_max_state(time_state):
	var max_state = 0
	for world_id in range(time_state.get_world_count()):
		max_state = max(time_state.get_world_state(world_id).length(), max_state)
	return max_state